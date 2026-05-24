# Scientific Documents

AMA mobile plugin category for scientific document inspection, Markdown extraction, and document-writing guidance.

Version `0.1.0` exposes two AMA Swift host intents:

- `scientific.document_inspect`
- `scientific.document_to_markdown`

The host intents support mobile-safe artifact inspection and Markdown extraction from text-like files, CSV/TSV, JSON, XML/HTML, and Markdown. Binary document formats must be converted to Markdown before import; Office editing and advanced conversion are installed as reference guidance only until AMA has native Swift document editors for those formats.

This pack does not ship Python, shell, Node, PowerShell, batch, LibreOffice, MarkItDown, or desktop helper scripts.
