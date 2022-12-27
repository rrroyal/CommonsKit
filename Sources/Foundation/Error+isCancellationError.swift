//
//  Error+isCancellationError.swift
//  CommonKit
//
//  Created by royal on 26/12/2022.
//

import Foundation

public extension Error {
	/// A Boolean value indicating whether this error is related to task cancellation.
	var isCancellationError: Bool {
		switch self {
			case is CancellationError:
				return true
			case let error as URLError:
				return error.code == URLError.cancelled
			default:
				return false
		}
	}
}
