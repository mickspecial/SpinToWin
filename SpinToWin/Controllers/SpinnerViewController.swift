//
//  SpinnerViewController.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {

	private let spinnerView: SpinnerView!
	private var spinBtn: UIButton!
	private let powerLevels: [Int] = Array(6...20)
	private lazy var spinAnimator = UIDynamicAnimator(referenceView: view)

	private var isSpinning = false {
		didSet {
			// only allow one spin at a time
			spinBtn.isHidden = isSpinning
		}
	}

	private var randomSpinPower: Int {
		return powerLevels.randomElement()!
	}

	init(spinnerItems: [SpinnerItem]) {
		spinnerView = SpinnerView(options: spinnerItems)
		super.init(nibName: nil, bundle: nil)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setUpController()
		addButtons()
		addWheel()
		addWinningMarker()
    }

	// MARK: - Spin

	@objc private func spinPressed() {
		if isSpinning { return }
		isSpinning = true
		spin(power: randomSpinPower)
	}

	private func spin(power: Int) {
		// spin using physics
		let rotate = UIDynamicItemBehavior(items: [spinnerView])
		rotate.allowsRotation = true
		// add some randoness to the spin
		let resistanceChoices = [CGFloat(0.4), CGFloat(0.5), CGFloat(0.6), CGFloat(0.8), CGFloat(1), CGFloat(1.1)]
		// using force unwrap here because impossible to not to exist
		rotate.angularResistance = resistanceChoices.randomElement()!
		rotate.addAngularVelocity(CGFloat(power), for: spinnerView)
		spinAnimator.removeAllBehaviors()
		spinAnimator.addBehavior(rotate)
	}

	// MARK: - Set Up

	private func setUpController() {
		title = "Lucky Wheel"
		view.backgroundColor = UIColor.flatColor.gray.twinkle
		spinAnimator.delegate = self
	}

	private func addWheel() {
		view.addSubview(spinnerView)
		let spinnerWidth = UIScreen.main.bounds.width * 0.85
		spinnerView.centerInSuperview(size: .init(width: spinnerWidth, height: spinnerWidth))
	}

	private func addButtons() {
		// spin button
		spinBtn = UIButton(title: "Spin", titleColor: .white, font: .boldSystemFont(ofSize: 24), backgroundColor: UIColor.flatColor.green.emerald, target: self, action: #selector(spinPressed))
		spinBtn.layer.cornerRadius = 30
		view.addSubview(spinBtn)
		spinBtn.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 50, right: 0), size: .init(width: 120, height: 60))
		spinBtn.centerXInSuperview()
	}

	private func addWinningMarker() {
		// small triangle to the right of the wheel
		let crossoverAmount: CGFloat = 8
		let winningMarker = TriangleView()
		view.addSubview(winningMarker)
		winningMarker.anchor(top: nil, leading: nil, bottom: nil, trailing: spinnerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -crossoverAmount), size: .init(width: 20, height: 20))
		winningMarker.centerYInSuperview()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SpinnerViewController: UIDynamicAnimatorDelegate {
	func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
		// when the spin completes can allow another spin
		isSpinning = false
	}
}
