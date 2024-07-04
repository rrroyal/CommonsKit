//
//  Collection+sorted.swift
//  CommonKit
//
//  Created by royal on 04/07/2024.
//

import Foundation

// MARK: - Sequence+sorted

public extension Sequence {
	@inlinable
	func sorted<T: Comparable>(
		by keyPath: KeyPath<Element, T>,
		using comparator: (T, T) -> Bool = (<)
	) -> [Element] {
		sorted {
			comparator($0[keyPath: keyPath], $1[keyPath: keyPath])
		}
	}
}

// MARK: - Sequence+localizedSorted

public extension Sequence {
	@inlinable
	func localizedSorted(
		by keyPath: KeyPath<Element, String>,
		using comparisionResult: ComparisonResult = .orderedAscending
	) -> [Element] {
		sorted {
			$0[keyPath: keyPath].localizedStandardCompare($1[keyPath: keyPath]) == comparisionResult
		}
	}

	@inlinable
	func localizedSorted(
		by keyPath: KeyPath<Element, String?>,
		using comparisionResult: ComparisonResult = .orderedAscending
	) -> [Element] {
		sorted {
			($0[keyPath: keyPath] ?? "").localizedStandardCompare($1[keyPath: keyPath] ?? "") == comparisionResult
		}
	}
}

public extension Sequence where Element == String {
	@inlinable
	func localizedSorted(
		using comparisionResult: ComparisonResult = .orderedAscending
	) -> [Element] {
		sorted {
			$0.localizedStandardCompare($1) == comparisionResult
		}
	}
}
