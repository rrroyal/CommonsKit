//
//  String+.swift
//  CommonKit
//
//  Created by royal on 26/12/2022.
//

import Foundation

public extension String {
	/// A Boolean value indicating whether a string has actually no characters (after trimming whitespaces and newlines).
	var isReallyEmpty: Bool {
		trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
	}
}

public extension String? {
	/// A Boolean value indicating whether a string has actually no characters (after trimming whitespaces and newlines).
	var isReallyEmpty: Bool {
		self?.isReallyEmpty ?? true
	}
}
