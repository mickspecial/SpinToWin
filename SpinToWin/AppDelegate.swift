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

		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let spinnerVC = SpinnerListController(collectionViewLayout: layout)
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = UINavigationController(rootViewController: spinnerVC)
		window?.makeKeyAndVisible()
		return true
	}
}

