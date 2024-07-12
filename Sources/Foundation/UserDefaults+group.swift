//
//  UserDefaults+group.swift
//  CommonKit
//
//  Created by royal on 26/12/2022.
//

import Foundation

public extension UserDefaults {
	/// Group UserDefaults.
	static var group: UserDefaults? {
		UserDefaults(suiteName: "group.\(Bundle.main.mainBundleIdentifier ?? Bundle.main.bundleIdentifier ?? "")")
	}
}
