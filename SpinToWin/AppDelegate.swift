//
//  AppDelegate.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		// Load a user from defaults - allows for item saving etc
		User.current = User.load() ?? User()

		print(User.current.items)

		if User.current.items.isEmpty {
			print("Options Added")
			let someDefaults = [
				SpinnerItem(itemName: "🍏"),
				SpinnerItem(itemName: "🍔"),
				SpinnerItem(itemName: "🍬"),
				SpinnerItem(itemName: "🍦"),
				SpinnerItem(itemName: "🍕")
			]

			User.current.items = someDefaults
			User.current.save()
		}

		// Set up VC as not using storyboards
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let spinnerVC = SpinnerListController(collectionViewLayout: layout)
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = UINavigationController(rootViewController: spinnerVC)
		window?.makeKeyAndVisible()
		return true
	}
}

