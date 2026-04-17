import Foundation

struct ClipboardHistoryItem: Codable, Equatable, Identifiable {
    let id: UUID
    let text: String
    let copiedAt: Date

    init(id: UUID = UUID(), text: String, copiedAt: Date = .now) {
        self.id = id
        self.text = text
        self.copiedAt = copiedAt
    }

    var previewText: String {
        text
            .replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
