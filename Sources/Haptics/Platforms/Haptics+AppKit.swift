//
//  Haptics+AppKit.swift
//  CommonKit
//
//  Created by royal on 26/12/2022.
//

#if canImport(AppKit) && !canImport(UIKit)
import AppKit
import Foundation

extension Haptics {
	@MainActor @inlinable
	static func generateHapticForCurrentPlatform(style: Haptics.HapticStyle) {
		// TODO: Haptics+AppKit
	}
}
#endif
