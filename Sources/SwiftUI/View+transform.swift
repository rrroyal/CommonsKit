//
//  View+transform.swift
//  CommonSwiftUI
//
//  Created by royal on 22/12/2025.
//

import SwiftUI

public extension View {
	/// Transforms the view using the provided closure while preserving the view's identity.
	/// - Parameter transform: Closure transforming the view.
	/// - Returns: Transformed view.
	@ViewBuilder
	func transform(@ViewBuilder transform: (_ view: Self) -> some View) -> some View {
		transform(self)
	}
}
