import AppKit
import SwiftUI

struct SettingsView: View {
    @ObservedObject var store: ClipboardHistoryStore
    @ObservedObject var settings: AppSettings

    private var historyLimitBinding: Binding<Int> {
        Binding(
            get: { store.historyLimit },
            set: { store.updateHistoryLimit(to: $0) }
        )
    }

    private var languageBinding: Binding<AppLanguage> {
        Binding(
            get: { settings.language },
            set: { settings.updateLanguage($0) }
        )
    }

    private var launchAtLoginBinding: Binding<Bool> {
        Binding(
            get: { settings.launchAtLoginEnabled },
            set: { settings.updateLaunchAtLogin($0) }
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                SettingsCard(
                    titleKey: "settings.language.section",
                    messageKey: "settings.language.footer"
                ) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("settings.language.label")
                            .font(.body.weight(.medium))

                        Picker("settings.language.label", selection: languageBinding) {
                            ForEach(AppLanguage.allCases) { language in
                                Text(language.titleKey)
                                    .tag(language)
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                    }
                }

                SettingsCard(
                    titleKey: "settings.history.section",
                    messageKey: "settings.history.footer"
                ) {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("settings.limit.label")
                                    .font(.body.weight(.medium))

                                Spacer(minLength: 16)

                                Text(store.historyLimit.formatted())
                                    .font(.body.monospacedDigit())
                                    .foregroundStyle(.secondary)
                            }

                            Stepper(
                                value: historyLimitBinding,
                                in: ClipboardHistoryStore.minimumHistoryLimit...ClipboardHistoryStore.maximumHistoryLimit,
                                step: ClipboardHistoryStore.historyStep
                            ) {
                                EmptyView()
                            }
                            .labelsHidden()
                        }

                        Divider()

                        HStack {
                            Text("settings.currentCount.label")
                                .font(.body.weight(.medium))

                            Spacer(minLength: 16)

                            Text(store.items.count.formatted())
                                .font(.body.monospacedDigit())
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                SettingsCard(
                    titleKey: "settings.startup.section",
                    messageKey: "settings.startup.footer"
                ) {
                    VStack(alignment: .leading, spacing: 10) {
                        Toggle("settings.startup.toggle", isOn: launchAtLoginBinding)
                            .toggleStyle(.switch)

                        if settings.launchAtLoginNeedsApproval {
                            Text("settings.startup.approval")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }

                SettingsCard(
                    titleKey: "settings.actions.section",
                    messageKey: "settings.actions.footer"
                ) {
                    HStack(spacing: 12) {
                        Button("history.clear", role: .destructive) {
                            store.clearHistory()
                        }
                        .disabled(store.items.isEmpty)

                        Spacer()

                        Button("app.quit", action: quitApp)
                            .keyboardShortcut("q")
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(nsColor: .windowBackgroundColor))
    }

    private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}

private struct SettingsCard<Content: View>: View {
    let titleKey: LocalizedStringKey
    let messageKey: LocalizedStringKey
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(titleKey)
                    .font(.headline)

                Text(messageKey)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            content
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(nsColor: .controlBackgroundColor))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.secondary.opacity(0.12), lineWidth: 1)
        )
    }
}
