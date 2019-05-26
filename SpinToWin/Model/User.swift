//
//  User.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

// Simple DB to allow saving the spinner options

import Foundation

extension User {
	static var current: User!
}

class User: Codable {
	var items = [SpinnerItem]()
}

extension User {
	// The key where the real user is stored
	fileprivate static var userKeyName: String { return "User" }

	// Loads a user from UserDefaults, or returns nil if none
	static func load() -> User? {
		let decoder = JSONDecoder()
		let defaults = UserDefaults.standard

		if let data = defaults.data(forKey: userKeyName) {
			if let decodedUser = try? decoder.decode(User.self, from: data) {
				print("Load Success")
				return decodedUser
			}
		}

		return nil
	}

	// Saves a user to user defaults
	func save() {
		let encoder = JSONEncoder()

		if let encodedUser = try? encoder.encode(self) {
			let defaults = UserDefaults.standard
			defaults.set(encodedUser, forKey: User.userKeyName)
			print("Save Success")
		}
	}

	// Destroys any existing
	static func destroyUser() {
		let defaults = UserDefaults.standard
		defaults.removeObject(forKey: userKeyName)
	}
}
