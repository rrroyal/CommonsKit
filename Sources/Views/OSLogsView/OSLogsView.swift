//
//  OSLogsView.swift
//  CommonKit
//
//  Created by royal on 20/06/2025.
//

import CommonFoundation
import CommonOSLog
import OSLog
import SwiftUI

public struct OSLogsView: View {
	@State private var isLoading: Bool = true
	@State private var logsTask: Task<Void, Never>?
	@State private var logs: [OSLogEntryLog] = []
	@State private var error: Error?
	@State private var filter: String = ""
	@State private var newestOnTop: Bool = true

	let osLogStorePosition: @Sendable (OSLogStore) -> OSLogPosition?
	let additionalOSLogPredicates: [NSPredicate]

	public init(
		osLogStorePosition: @Sendable @escaping (OSLogStore) -> OSLogPosition = {
			$0.position(date: Date.now.addingTimeInterval(-(24 * 60 * 60)))
		},
		additionalOSLogPredicates: [NSPredicate] = []
	) {
		self.osLogStorePosition = osLogStorePosition
		self.additionalOSLogPredicates = additionalOSLogPredicates
	}

	private var filteredLogs: [OSLogEntryLog] {
		guard !filter.isEmpty else { return logs }
		return logs.filter {
			$0.composedMessage.localizedCaseInsensitiveContains(filter) ||
			$0.category.localizedCaseInsensitiveContains(filter) ||
			$0.levelReadable.localizedCaseInsensitiveContains(filter)
		}
	}

	public var body: some View {
		let filteredLogs = self.filteredLogs
		List {
			ForEach(newestOnTop ? filteredLogs.reversed() : filteredLogs, id: \.self) { entry in
				Section {
					Text(entry.composedMessage)
						.font(.footnote)
						.fontDesign(.monospaced)
						.multilineTextAlignment(.leading)
						.lineLimit(nil)
						.textSelection(.enabled)
				} header: {
					HStack {
						Text(entry.category)
						Spacer()
						Text(entry.levelReadable)
					}
					.font(.caption2)
					.fontDesign(.monospaced)
					.textCase(.none)
					.lineLimit(2)
				} footer: {
					Text(entry.date.ISO8601Format())
						.font(.caption2)
						.fontDesign(.monospaced)
						.textCase(.none)
						.lineLimit(2)
				}
				.listRowBackground(
					Color(uiColor: .secondarySystemGroupedBackground)
						.mix(with: entry.color ?? .clear, by: entry.color != nil ? 0.16 : 0)
				)
			}
		}
		.listStyle(.grouped)
		.scrollContentBackground(.hidden)
		.searchable(text: $filter)
		.refreshable {
			await getLogs().value
		}
		.navigationTitle(String(localized: "OSLogsView.Title", bundle: .module))
		.toolbar {
			toolbarContent
		}
		.background {
			if filteredLogs.isEmpty {
				if isLoading {
					ProgressView()
				} else {
					if !filter.isEmpty {
						ContentUnavailableView.search(text: filter)
					} else {
						ContentUnavailableView(String(localized: "OSLogsView.NoLogsAvailable", bundle: .module), systemImage: "text.page.slash")
					}
				}
			}
		}
		.background(Color(uiColor: .systemGroupedBackground))
		.task {
			await getLogs().value
		}
		.animation(.default, value: filteredLogs)
		.animation(.default, value: filter)
		.animation(.default, value: isLoading)
		.animation(.default, value: newestOnTop)
	}
}

// MARK: - Subviews

private extension OSLogsView {
	@ToolbarContentBuilder
	private var toolbarContent: some ToolbarContent {
		ToolbarItem(placement: .primaryAction) {
			Menu {
				Toggle(
					String(localized: "OSLogsView.NewestOnTop", bundle: .module),
					systemImage: "text.line.first.and.arrowtriangle.forward",
					isOn: $newestOnTop
				)

				Divider()

				ShareLink(item: createShareableLogs())
			} label: {
				Label(String(localized: "Generic.More", bundle: .module), systemImage: "ellipsis")
					.labelStyle(.iconOnly)
			}
		}
	}
}

// MARK: - Actions

private extension OSLogsView {
	@discardableResult
	func getLogs() -> Task<Void, Never> {
		nonisolated(unsafe) let additionalOSLogPredicates = self.additionalOSLogPredicates

		self.logsTask?.cancel()
		let task = Task.detached { @Sendable in
			Task { @MainActor in
				isLoading = true
			}
			defer {
				Task { @MainActor in
					isLoading = false
				}
			}

		fetchLogs:
			do {
				let logStore = try OSLogStore(scope: .currentProcessIdentifier)

				let predicates: [NSPredicate] = [
					NSPredicate(format: "subsystem CONTAINS[c] %@", Bundle.main.bundleIdentifier ?? "")
				] + additionalOSLogPredicates

				let entries = try logStore.getEntries(
					at: osLogStorePosition(logStore),
					matching: NSCompoundPredicate(
						type: .or,
						subpredicates: predicates
					)
				)

				guard !Task.isCancelled else { break fetchLogs }

				let logs = entries.compactMap { $0 as? OSLogEntryLog }
				await MainActor.run {
					self.logs = logs
				}
			} catch {
				await MainActor.run {
					self.error = error
				}
			}
		}
		self.logsTask = task
		return task
	}

	func createShareableLogs() -> String {
		logs
			.map(\.descriptionReadable)
			.joined(separator: "\n")
	}
}

// MARK: - OSLogEntryLog+UI

private extension OSLogEntryLog {
	var descriptionReadable: String {
		"\(date.ISO8601Format()) [\(category)] (\(levelReadable)) \(composedMessage)"
	}

	var color: Color? {
		switch level {
		case .debug:		.purple
		case .info:			nil
		case .notice:		.blue
		case .error:		.yellow
		case .fault:		.red
		case .undefined:	nil
		@unknown default:	nil
		}
	}

	var levelReadable: String {
		switch level {
		case .debug:		String(localized: "OSLogEntryLog.Level.Debug", bundle: .module)
		case .info:			String(localized: "OSLogEntryLog.Level.Info", bundle: .module)
		case .notice:		String(localized: "OSLogEntryLog.Level.Notice", bundle: .module)
		case .error:		String(localized: "OSLogEntryLog.Level.Error", bundle: .module)
		case .fault:		String(localized: "OSLogEntryLog.Level.Fault", bundle: .module)
		case .undefined:	String(localized: "OSLogEntryLog.Level.None", bundle: .module)
		@unknown default:	String(localized: "OSLogEntryLog.Level.Unknown", bundle: .module)
		}
	}
}

// MARK: - Previews

#Preview {
	NavigationStack {
		OSLogsView()
	}
}
