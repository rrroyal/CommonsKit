//
//  View+hidden.swift
//  Harbour
//
//  Created by royal on 29/10/2022.
//

import SwiftUI

public extension View {
	/// Hides this view conditionally.
	/// - Parameter isHidden: A Boolean value indicating whether the view should be hidden or not
	/// - Returns: Optionally hidden `View`
	@ViewBuilder @inlinable
	func hidden(_ isHidden: Bool) -> some View {
		if isHidden {
			hidden()
		} else {
			self
		}
	}
}
