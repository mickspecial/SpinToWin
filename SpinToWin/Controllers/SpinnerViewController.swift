//
//  SpinnerViewController.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {

	private let spinnerItems: [SpinnerItem]!

	let spinnerView: UIView = {
		let view = UIView(frame: .zero)
		view.backgroundColor = .red
		return view
	}()

	init(spinnerItems: [SpinnerItem]) {
		self.spinnerItems = spinnerItems
		precondition(spinnerItems.count >= 2, "need more items for spinner")
		super.init(nibName: nil, bundle: nil)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpController()
		addButtons()
		addSpinner()
    }

	private func setUpController() {
		title = "Lucky Wheel"
		view.backgroundColor = UIColor.flatColor.gray.twinkle
		navigationController?.navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.tintColor = UIColor.flatColor.gray.balticSea
		navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.flatColor.gray.balticSea]
	}

	private func addSpinner() {
		view.addSubview(spinnerView)
		let spinnerWidth = UIScreen.main.bounds.width * 0.85
		spinnerView.centerInSuperview(size: .init(width: spinnerWidth, height: spinnerWidth))
	}

	private func addButtons() {
		// floating spin pill button
		let spinBtn = UIButton(title: "Spin", titleColor: .white, font: .boldSystemFont(ofSize: 24), backgroundColor: UIColor.flatColor.green.emerald, target: self, action: #selector(spinPressed))
		spinBtn.layer.cornerRadius = 30
		view.addSubview(spinBtn)
		spinBtn.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 50, right: 0), size: .init(width: 120, height: 60))
		spinBtn.centerXInSuperview()
	}

	// MARK: - Spin
	@objc private func spinPressed() {
		print("Spin....")
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
