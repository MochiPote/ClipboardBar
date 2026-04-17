import AppKit
import SwiftUI

struct ClipboardHistoryView: View {
    @ObservedObject var store: ClipboardHistoryStore
    @ObservedObject var settings: AppSettings
    @State private var copiedItemID: ClipboardHistoryItem.ID?

    var body: some View {
        VStack(spacing: 14) {
            header
            Divider()

            if store.items.isEmpty {
                emptyState
            } else {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(store.items) { item in
                            ClipboardHistoryRow(
                                item: item,
                                isCopied: copiedItemID == item.id,
                                onCopy: { handleCopy(item) },
                                onDelete: { store.remove(item) }
                            )
                        }
                    }
                    .padding(.vertical, 2)
                }
            }

            Divider()
            footer
        }
        .padding(14)
        .background(.regularMaterial)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("history.title")
                        .font(.headline)
                    Text("history.subtitle")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button(role: .destructive, action: store.clearHistory) {
                    Image(systemName: "trash")
                }
                .buttonStyle(.borderless)
                .disabled(store.items.isEmpty)
                .help(Text("history.clear"))
            }

            HStack(spacing: 8) {
                Text("history.count.label")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(store.items.count.formatted())
                    .font(.caption.monospacedDigit().weight(.semibold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.secondary.opacity(0.12))
                    )
            }
        }
    }

    private var footer: some View {
        HStack(spacing: 10) {
            SettingsLink {
                Label("settings.open", systemImage: "gearshape")
            }
            .buttonStyle(.bordered)

            Spacer()

            Button(action: quitApp) {
                Label("app.quit", systemImage: "power")
            }
            .buttonStyle(.bordered)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Spacer()

            Image(systemName: "doc.on.clipboard")
                .font(.system(size: 34))
                .foregroundStyle(.secondary)

            Text("history.empty.title")
                .font(.headline)

            Text("history.empty.body")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 260)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private func handleCopy(_ item: ClipboardHistoryItem) {
        store.copy(item)

        withAnimation(.easeInOut(duration: 0.2)) {
            copiedItemID = item.id
        }

        Task { @MainActor in
            try? await Task.sleep(for: .seconds(1.2))

            if copiedItemID == item.id {
                withAnimation(.easeInOut(duration: 0.2)) {
                    copiedItemID = nil
                }
            }
        }
    }

    private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}

private struct ClipboardHistoryRow: View {
    let item: ClipboardHistoryItem
    let isCopied: Bool
    let onCopy: () -> Void
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                Group {
                    if item.previewText.isEmpty {
                        Text("history.row.empty")
                    } else {
                        Text(item.text)
                    }
                }
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(3)

                Text(item.copiedAt, style: .relative)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize()
            }

            HStack(spacing: 8) {
                Button(action: onCopy) {
                    Label(isCopied ? "button.copied" : "button.copy", systemImage: isCopied ? "checkmark.circle.fill" : "doc.on.doc")
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)

                Button(role: .destructive, action: onDelete) {
                    Label("button.delete", systemImage: "trash")
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Spacer()
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(nsColor: .controlBackgroundColor))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(isCopied ? Color.accentColor.opacity(0.5) : Color.secondary.opacity(0.15), lineWidth: isCopied ? 1.5 : 1)
        )
        .contentShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .onTapGesture(perform: onCopy)
        .contextMenu {
            Button("button.copy", action: onCopy)
            Button("button.delete", role: .destructive, action: onDelete)
        }
    }
}
