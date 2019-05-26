//
//  SpinnerItem.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import Foundation

struct SpinnerItem: Codable {

	let itemName: String
	let id: String

	init(itemName: String) {
		self.itemName = itemName
		self.id = UUID().uuidString
	}
}
