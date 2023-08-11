//
//  NSManagedObjectContext+saveIfNeeded.swift
//  CommonKit
//
//  Created by royal on 26/12/2022.
//

import CoreData

public extension NSManagedObjectContext {
	/// Only performs a save if there are changes to commit.
	/// - Returns: `true` if a save was needed. Otherwise, `false`.
	@discardableResult func saveIfNeeded() throws -> Bool {
		guard hasChanges else { return false }
		try save()
		return true
	}
}
