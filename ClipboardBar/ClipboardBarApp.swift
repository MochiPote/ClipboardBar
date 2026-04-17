import AppKit
import SwiftUI

@main
struct ClipboardBarApp: App {
    @StateObject private var historyStore = ClipboardHistoryStore()
    @StateObject private var appSettings = AppSettings()

    init() {
        NSApplication.shared.setActivationPolicy(.accessory)
    }

    var body: some Scene {
        MenuBarExtra {
            ClipboardHistoryView(store: historyStore, settings: appSettings)
                .environment(\.locale, appSettings.locale)
                .frame(minWidth: 360, idealWidth: 380, maxWidth: 420, minHeight: 420, idealHeight: 500, maxHeight: 560)
        } label: {
            Label("app.name", systemImage: "doc.on.clipboard")
                .environment(\.locale, appSettings.locale)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView(store: historyStore, settings: appSettings)
                .environment(\.locale, appSettings.locale)
                .frame(minWidth: 560, idealWidth: 600, minHeight: 460, idealHeight: 500)
        }
    }
}
