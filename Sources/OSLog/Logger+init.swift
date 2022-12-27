//
//  Logger+init.swift
//  CommonKit
//
//  Created by royal on 26/12/2022.
//

import OSLog

// MARK: - Logger+init

public extension Logger {
	/// Convenience initializer with `subsystem` already filled in.
	/// - Parameter category: Category of `Logger`
	@inlinable
	init(category: String) {
		self.init(subsystem: Bundle.main.bundleIdentifier ?? "", category: category)
	}
}
