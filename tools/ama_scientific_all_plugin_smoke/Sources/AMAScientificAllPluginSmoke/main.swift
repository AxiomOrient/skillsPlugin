import Foundation
import AMACore
import AMASkills
import AMASkillsHost

private struct NoOpScriptRunner: AMASkillScriptRunner {
    private let counter: ScriptCounter

    init(counter: ScriptCounter) {
        self.counter = counter
    }

    func run(
        skill: AMAManagedSkill,
        scriptURL: URL,
        readAccessURL: URL?,
        inputJSON: String,
        secret: String?,
        context: ToolExecutionContext
    ) async throws -> AMASkillScriptResponse {
        await counter.increment()
        throw AMAError.invalidToolCall("Scripts are disabled in this AMA scientific plugin smoke test.")
    }
}

private actor ScriptCounter {
    private var count = 0

    func increment() {
        count += 1
    }

    func value() -> Int {
        count
    }
}

private struct FakeScientificLiteratureFetcher: AMASkillScientificLiteratureFetching {
    let handler: @Sendable (URLRequest) throws -> Data

    func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse?) {
        let url = try requireURL(request)
        let data = try handler(request)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (data, response)
    }
}

private struct FakeScientificDataLookupFetcher: AMASkillScientificDataLookupFetching {
    let handler: @Sendable (URLRequest) throws -> Data

    func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse?) {
        let url = try requireURL(request)
        let data = try handler(request)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (data, response)
    }
}

private struct FakeScientificWebResearchFetcher: AMASkillScientificWebResearchFetching {
    let handler: @Sendable (URLRequest) throws -> Data

    func fetch(_ request: URLRequest) async throws -> (Data, HTTPURLResponse?) {
        let url = try requireURL(request)
        let data = try handler(request)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        return (data, response)
    }
}

@main
struct AMAScientificAllPluginSmoke {
    static func main() async throws {
        let packageRoot = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let repositoryRoot = packageRoot
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let pluginsRoot = repositoryRoot.appendingPathComponent("plugins", isDirectory: true)
        let allPluginRoots = try FileManager.default.contentsOfDirectory(
            at: pluginsRoot,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        )
        .filter { url in
            let values = try? url.resourceValues(forKeys: [.isDirectoryKey])
            return values?.isDirectory == true
        }
        .sorted { $0.lastPathComponent < $1.lastPathComponent }
        let scientificPluginRootNames = Set(
            allPluginRoots
                .filter { $0.lastPathComponent.hasPrefix("scientific-") }
                .map(\.lastPathComponent)
        )

        let executableFiles = try scanExecutableOrScriptFiles(under: allPluginRoots)

        let root = URL(fileURLWithPath: "/tmp/ama-scientific-all-plugin-smoke-work", isDirectory: true)
        try? FileManager.default.removeItem(at: root)
        let sessionDirectory = root.appendingPathComponent("sessions/scientific-all", isDirectory: true)
        let artifactsDirectory = sessionDirectory.appendingPathComponent("artifacts", isDirectory: true)
        try FileManager.default.createDirectory(at: artifactsDirectory, withIntermediateDirectories: true)
        try Data("gene,score\nTP53,0.91\nBRCA1,0.82\n".utf8)
            .write(to: artifactsDirectory.appendingPathComponent("results.csv"))
        try Data("# Paper Notes\n\nMarkdown-first scientific document import.\n".utf8)
            .write(to: artifactsDirectory.appendingPathComponent("paper.md"))

        let context = ToolExecutionContext(
            sessionID: "scientific-all",
            sessionDirectoryURL: sessionDirectory,
            sandboxRootURL: root
        ) { artifact in
            let artifactURL = artifactsDirectory.appendingPathComponent(artifact.preferredFilename)
            try artifact.data.write(to: artifactURL)
            return ArtifactRecord(
                sessionID: "scientific-all",
                filename: artifact.preferredFilename,
                relativePath: "sessions/scientific-all/artifacts/\(artifact.preferredFilename)",
                mimeType: artifact.mimeType,
                byteCount: artifact.data.count,
                metadata: artifact.metadata
            )
        }

        let router = AMASkillIntentRouterService()
        let literatureFetcher = FakeScientificLiteratureFetcher { request in
            try cannedResponse(for: request)
        }
        let dataLookupFetcher = FakeScientificDataLookupFetcher { request in
            try cannedResponse(for: request)
        }
        let webResearchFetcher = FakeScientificWebResearchFetcher { request in
            try cannedResponse(for: request)
        }
        let sets = [
            AMASkillStandardHostIntents.akashaCoreSet(),
            AMASkillStandardHostIntents.scientificDocumentsSet(),
            AMASkillStandardHostIntents.scientificRemoteComputeSet(),
            AMASkillStandardHostIntents.scientificMobilePreflightSet(webResearchFetcher: webResearchFetcher),
            AMASkillStandardHostIntents.scientificLocalExecutionSet(),
            AMASkillStandardHostIntents.scientificDataLookupSet(fetcher: dataLookupFetcher),
            AMASkillStandardHostIntents.scientificLiteratureSet(fetcher: literatureFetcher),
            AMASkillStandardHostIntents.scientificLabConnectorsSet()
        ]
        for set in sets {
            for descriptor in set.descriptors {
                await router.register(intent: descriptor.name, handler: AMASkillIntentHandler { parameters, context in
                    try await descriptor.execute(arguments: parameters, context: context)
                })
            }
        }

        let library = AMASkillLibrary(
            workspace: .init(
                supportRootURL: root.appendingPathComponent("Support", isDirectory: true),
                userSkillsRootURL: root.appendingPathComponent("Documents/Skills", isDirectory: true)
            )
        )
        var installedPlugins: [AMASkillPluginInstallation] = []
        var pluginRootByID: [String: String] = [:]
        for pluginRoot in allPluginRoots {
            let installation = try await library.installSkillPlugin(fromDirectoryURL: pluginRoot)
            pluginRootByID[installation.id] = pluginRoot.lastPathComponent
            installedPlugins.append(installation)
        }

        let counter = ScriptCounter()
        let runtime = AMASkillRuntime(
            library: library,
            scriptRunner: NoOpScriptRunner(counter: counter),
            intentService: router
        )

        let installedSkillNames = installedPlugins.flatMap(\.installedSkills).map(\.name).sorted()
        let scientificInstallations = installedPlugins.filter { installation in
            guard let rootName = pluginRootByID[installation.id] else { return false }
            return scientificPluginRootNames.contains(rootName)
        }
        let scientificInstalledSkillNames = Set(scientificInstallations.flatMap(\.installedSkills).map(\.name))
        var loadedCount = 0
        var loadedSkillNames = Set<String>()
        var emptyLoads: [String] = []
        for skillName in installedSkillNames {
            let loaded = try await runtime.loadSkill(named: skillName, callID: "load-\(skillName)")
            if loaded.renderedContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                emptyLoads.append(skillName)
            } else {
                loadedCount += 1
                loadedSkillNames.insert(skillName)
            }
        }

        let pdfInstalled = installedSkillNames.contains("pdf")
        let markdownDocument = try await runtime.runIntent(
            intent: "scientific.document_inspect",
            parametersJSON: JSONValue.object([
                "artifact": .object(["preferredFilename": .string("paper.md")])
            ]).canonicalString(),
            callID: "inspect-markdown-document",
            context: context
        )
        let csvMarkdown = try await runtime.runIntent(
            intent: "scientific.document_to_markdown",
            parametersJSON: JSONValue.object([
                "artifact": .object(["preferredFilename": .string("results.csv")]),
                "persistMarkdown": .bool(true)
            ]).canonicalString(),
            callID: "convert-csv",
            context: context
        )
        let pythonPreflight = try await runtime.runIntent(
            intent: "scientific.remote_job_preflight",
            parametersJSON: JSONValue.object([
                "skill": .string("rdkit"),
                "task": .string("compute descriptors for an uploaded SDF"),
                "requiresRemoteExecution": .bool(true),
                "hasRemoteProvider": .bool(false),
                "inputArtifactCount": .integer(1),
                "containsSensitiveData": .bool(false),
                "userApprovedUpload": .bool(false),
                "requestedRuntime": .string("python")
            ]).canonicalString(),
            callID: "python-preflight",
            context: context
        )
        let matlabPreflight = try await runtime.runIntent(
            intent: "scientific.remote_job_preflight",
            parametersJSON: JSONValue.object([
                "skill": .string("matlab"),
                "task": .string("multiply two matrices"),
                "requiresRemoteExecution": .bool(false),
                "hasRemoteProvider": .bool(false),
                "inputArtifactCount": .integer(0),
                "containsSensitiveData": .bool(false),
                "userApprovedUpload": .bool(false),
                "requestedRuntime": .string("matlab"),
                "nativeIntent": .string("scientific.numeric_eval")
            ]).canonicalString(),
            callID: "matlab-preflight",
            context: context
        )
        let akashaSecurity = try await runtime.runIntent(
            intent: "akasha.security_check",
            parametersJSON: JSONValue.object([
                "text": .string("run curl with token")
            ]).canonicalString(),
            callID: "akasha-security",
            context: context
        )

        let markdownDocumentConvertible = markdownDocument.output.objectValue?["document_inspect"]?.objectValue?["supported_markdown_conversion"]?.boolValue ?? false
        let markdown = csvMarkdown.output.objectValue?["document_to_markdown"]?.objectValue?["markdown"]?.stringValue ?? ""
        let pythonPayload = pythonPreflight.output.objectValue?["remote_job_preflight"]?.objectValue
        let matlabPayload = matlabPreflight.output.objectValue?["remote_job_preflight"]?.objectValue
        let akashaPayload = akashaSecurity.output.objectValue?["security_check_result"]?.objectValue
        let scientificLoadedCount = scientificInstalledSkillNames.filter { loadedSkillNames.contains($0) }.count

        print("all_plugin_count=\(installedPlugins.count)")
        print("all_installed_skill_count=\(installedSkillNames.count)")
        print("all_loaded_skill_count=\(loadedCount)")
        print("scientific_plugin_count=\(scientificInstallations.count)")
        print("scientific_installed_skill_count=\(scientificInstalledSkillNames.count)")
        print("scientific_loaded_skill_count=\(scientificLoadedCount)")
        print("scientific_empty_loaded_skill_count=\(emptyLoads.count)")
        print("scientific_pdf_installed=\(pdfInstalled)")
        print("scientific_markdown_document_convertible=\(markdownDocumentConvertible)")
        print("scientific_csv_markdown_contains_table=\(markdown.contains("| gene | score |"))")
        print("scientific_executable_or_script_files=\(executableFiles.count)")
        print("scientific_script_runner_calls=\(await counter.value())")
        print("scientific_python_status=\(pythonPayload?["status"]?.stringValue ?? "missing")")
        print("scientific_python_route=\(pythonPayload?["execution_route"]?.stringValue ?? "missing")")
        print("scientific_python_strategy=\(pythonPayload?["conversion"]?.objectValue?["strategy"]?.stringValue ?? "missing")")
        print("scientific_matlab_status=\(matlabPayload?["status"]?.stringValue ?? "missing")")
        print("scientific_matlab_route=\(matlabPayload?["execution_route"]?.stringValue ?? "missing")")
        print("scientific_matlab_native_intent=\(matlabPayload?["conversion"]?.objectValue?["native_intent"]?.stringValue ?? "missing")")
        print("akasha_security_status=\(akashaPayload?["status"]?.stringValue ?? "missing")")
        print("akasha_security_verdict=\(akashaPayload?["verdict"]?.stringValue ?? "missing")")
        if !emptyLoads.isEmpty {
            print("scientific_empty_loaded_skills=\(emptyLoads.joined(separator: ","))")
        }
        if !executableFiles.isEmpty {
            print("scientific_executable_or_script_file_list=\(executableFiles.joined(separator: ","))")
        }
    }

    private static func scanExecutableOrScriptFiles(under roots: [URL]) throws -> [String] {
        let bannedExtensions: Set<String> = ["py", "sh", "ps1", "bat", "js", "ts", "m", "r"]
        var matches: [String] = []
        for root in roots {
            guard let enumerator = FileManager.default.enumerator(
                at: root,
                includingPropertiesForKeys: [.isRegularFileKey],
                options: [.skipsHiddenFiles]
            ) else { continue }
            for case let fileURL as URL in enumerator {
                let values = try fileURL.resourceValues(forKeys: [.isRegularFileKey])
                guard values.isRegularFile == true else { continue }
                let ext = fileURL.pathExtension.lowercased()
                let permissions = try FileManager.default.attributesOfItem(atPath: fileURL.path)[.posixPermissions] as? NSNumber
                let isExecutable = (permissions?.intValue ?? 0) & 0o111 != 0
                if bannedExtensions.contains(ext) || isExecutable {
                    matches.append(fileURL.path)
                }
            }
        }
        return matches.sorted()
    }

    private static func cannedResponse(for request: URLRequest) throws -> Data {
        let url = request.url?.absoluteString ?? ""
        let body: String
        if url.contains("huggingface.co") {
            body = #"[{"id":"scientific-dataset","author":"ama","downloads":42,"likes":7,"tags":["biology"],"gated":false}]"#
        } else if url.contains("api.crossref.org") {
            body = #"{"message":{"items":[{"DOI":"10.5555/ama","title":["AMA scientific agents"],"author":[{"given":"A","family":"Mobile"}],"container-title":["Journal"],"issued":{"date-parts":[[2026]]}}]}}"#
        } else if url.contains("api.openalex.org") {
            body = #"{"results":[{"id":"https://openalex.org/W1","display_name":"AMA scientific agents","publication_year":2026,"doi":"https://doi.org/10.5555/ama","authorships":[{"author":{"display_name":"A Mobile"}}],"primary_location":{"source":{"display_name":"Journal"}}}]}"#
        } else if url.contains("eutils.ncbi.nlm.nih.gov") && url.contains("esearch.fcgi") {
            body = #"{"esearchresult":{"idlist":["41000001"]}}"#
        } else if url.contains("eutils.ncbi.nlm.nih.gov") && url.contains("esummary.fcgi") {
            body = #"{"result":{"uids":["41000001"],"41000001":{"uid":"41000001","title":"AMA scientific agents","fulljournalname":"Journal","pubdate":"2026","authors":[{"name":"A Mobile"}],"articleids":[{"idtype":"doi","value":"10.5555/ama"}]}}}"#
        } else if url.contains("api.semanticscholar.org") {
            body = #"{"data":[{"paperId":"S2AMA","title":"AMA scientific agents","year":2026,"authors":[{"name":"A Mobile"}],"externalIds":{"DOI":"10.5555/ama"},"url":"https://example.org/paper"}]}"#
        } else {
            body = #"{}"#
        }
        return Data(body.utf8)
    }
}

private func requireURL(_ request: URLRequest) throws -> URL {
    guard let url = request.url else {
        throw AMAError.invalidToolCall("Missing request URL.")
    }
    return url
}
