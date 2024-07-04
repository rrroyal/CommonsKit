//
//  Collection+safe.swift
//  CommonKit
//
//  Created by royal on 04/07/2024.
//

import Foundation

public extension Collection {
	/// Returns the element at the specified index if it is within bounds, otherwise nil.
	@inlinable
	subscript(safe index: Index) -> Element? {
		indices.contains(index) ? self[index] : nil
	}
}
