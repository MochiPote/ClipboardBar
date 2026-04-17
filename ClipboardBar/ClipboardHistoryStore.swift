import AppKit
import Foundation

final class ClipboardHistoryStore: ObservableObject {
    static let minimumHistoryLimit = 20
    static let maximumHistoryLimit = 200
    static let historyStep = 10

    @Published private(set) var items: [ClipboardHistoryItem]
    @Published private(set) var historyLimit: Int

    private let defaults: UserDefaults
    private let pasteboard: NSPasteboard
    private let historyStorageKey = "clipboardBar.history.items"
    private let historyLimitKey = "clipboardBar.history.limit"
    private var timer: Timer?
    private var lastObservedChangeCount: Int

    init(defaults: UserDefaults = .standard, pasteboard: NSPasteboard = .general) {
        self.defaults = defaults
        self.pasteboard = pasteboard
        self.historyLimit = Self.clampedHistoryLimit(defaults.object(forKey: "clipboardBar.history.limit") as? Int ?? 50)
        self.items = []
        self.lastObservedChangeCount = pasteboard.changeCount

        loadHistory()
        startMonitoring()
    }

    func updateHistoryLimit(to newValue: Int) {
        historyLimit = Self.clampedHistoryLimit(newValue)
        defaults.set(historyLimit, forKey: historyLimitKey)
        trimHistoryIfNeeded()
        persistHistory()
    }

    func copy(_ item: ClipboardHistoryItem) {
        copy(text: item.text, preferredID: item.id)
    }

    func remove(_ item: ClipboardHistoryItem) {
        items.removeAll { $0.id == item.id }
        persistHistory()
    }

    func clearHistory() {
        items.removeAll()
        persistHistory()
    }

    private func startMonitoring() {
        let timer = Timer(timeInterval: 0.6, repeats: true) { [weak self] _ in
            self?.pollPasteboard()
        }
        timer.tolerance = 0.2
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }

    private func pollPasteboard() {
        let currentChangeCount = pasteboard.changeCount
        guard currentChangeCount != lastObservedChangeCount else {
            return
        }

        lastObservedChangeCount = currentChangeCount

        guard let string = pasteboard.string(forType: .string) else {
            return
        }

        guard !normalized(string).isEmpty else {
            return
        }

        insertOrRefresh(string)
    }

    private func copy(text: String, preferredID: UUID? = nil) {
        pasteboard.clearContents()
        let didWrite = pasteboard.setString(text, forType: .string)

        guard didWrite else {
            return
        }

        lastObservedChangeCount = pasteboard.changeCount
        insertOrRefresh(text, preferredID: preferredID)
    }

    private func insertOrRefresh(_ text: String, preferredID: UUID? = nil) {
        let timestamp = Date()

        if let existingIndex = items.firstIndex(where: { $0.text == text }) {
            let existing = items.remove(at: existingIndex)
            let refreshed = ClipboardHistoryItem(id: preferredID ?? existing.id, text: existing.text, copiedAt: timestamp)
            items.insert(refreshed, at: 0)
        } else {
            items.insert(ClipboardHistoryItem(id: preferredID ?? UUID(), text: text, copiedAt: timestamp), at: 0)
        }

        trimHistoryIfNeeded()
        persistHistory()
    }

    private func trimHistoryIfNeeded() {
        guard items.count > historyLimit else {
            return
        }

        items = Array(items.prefix(historyLimit))
    }

    private func loadHistory() {
        guard let data = defaults.data(forKey: historyStorageKey) else {
            return
        }

        do {
            items = try JSONDecoder().decode([ClipboardHistoryItem].self, from: data)
            trimHistoryIfNeeded()
        } catch {
            items = []
        }
    }

    private func persistHistory() {
        do {
            let data = try JSONEncoder().encode(items)
            defaults.set(data, forKey: historyStorageKey)
        } catch {
            defaults.removeObject(forKey: historyStorageKey)
        }
    }

    private func normalized(_ text: String) -> String {
        text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func clampedHistoryLimit(_ value: Int) -> Int {
        min(max(value, minimumHistoryLimit), maximumHistoryLimit)
    }
}
