// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AMAScientificAllPluginSmoke",
    platforms: [
        .macOS(.v14)
    ],
    dependencies: [
        .package(path: "../../../AMA")
    ],
    targets: [
        .executableTarget(
            name: "AMAScientificAllPluginSmoke",
            dependencies: [
                .product(name: "AMA", package: "AMA")
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
