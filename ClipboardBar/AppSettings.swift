import ServiceManagement
import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case japanese = "ja"
    case chineseSimplified = "zh-Hans"

    static let storageKey = "clipboardBar.app.language"

    var id: String { rawValue }

    var locale: Locale {
        Locale(identifier: rawValue)
    }

    var titleKey: LocalizedStringKey {
        switch self {
        case .english:
            "language.english"
        case .japanese:
            "language.japanese"
        case .chineseSimplified:
            "language.chineseSimplified"
        }
    }

    static var defaultLanguage: AppLanguage {
        for preferredLanguage in Locale.preferredLanguages {
            let normalized = preferredLanguage.lowercased()

            if normalized.hasPrefix("ja") {
                return .japanese
            }

            if normalized.hasPrefix("zh") {
                return .chineseSimplified
            }

            if normalized.hasPrefix("en") {
                return .english
            }
        }

        return .english
    }
}

@MainActor
final class AppSettings: ObservableObject {
    @Published private(set) var language: AppLanguage
    @Published private(set) var launchAtLoginEnabled: Bool = false
    @Published private(set) var launchAtLoginNeedsApproval: Bool = false

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        if let storedLanguage = defaults.string(forKey: AppLanguage.storageKey),
           let language = AppLanguage(rawValue: storedLanguage) {
            self.language = language
        } else {
            let fallbackLanguage = AppLanguage.defaultLanguage
            self.language = fallbackLanguage
            defaults.set(fallbackLanguage.rawValue, forKey: AppLanguage.storageKey)
        }

        refreshLaunchAtLoginState()
    }

    var locale: Locale {
        language.locale
    }

    func updateLanguage(_ language: AppLanguage) {
        guard self.language != language else {
            return
        }

        self.language = language
        defaults.set(language.rawValue, forKey: AppLanguage.storageKey)
    }

    func updateLaunchAtLogin(_ enabled: Bool) {
        do {
            if enabled {
                try SMAppService.mainApp.register()
            } else {
                try SMAppService.mainApp.unregister()
            }
        } catch {
            // Keep the UI in sync with the OS state if register/unregister fails.
        }

        refreshLaunchAtLoginState()
    }

    private func refreshLaunchAtLoginState() {
        let status = SMAppService.mainApp.status
        launchAtLoginEnabled = status == .enabled
        launchAtLoginNeedsApproval = status == .requiresApproval
    }
}
