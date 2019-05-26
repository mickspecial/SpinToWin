//
//  SpinnerView.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import UIKit

class SpinnerView: UIView {

	private (set) var spinnerLabels = [UILabel]()

	init(options: [SpinnerItem]) {
		super.init(frame: .zero)
		assert(options.count >= 2 && options.count <= 10, "Wheel Design Limit")

		backgroundColor = UIColor.flatColor.blue.shipsOfficer
		layer.borderWidth = 4
		layer.borderColor = UIColor.flatColor.blue.disco.cgColor

		// used to calculate angle of the slice in the wheel
		// ie 2 slices is 180, 4 slices is 90
		let fraction = Double(360 / options.count)
		var current = fraction

		// shuffle the list to add some more randomness
		for option in options.shuffled() {
			let newSectionLabel = sectionLabel(name: option.itemName)
			spinnerLabels.append(newSectionLabel)
			addSubview(newSectionLabel)
			rotate(view: newSectionLabel, by: current)
			// each pie addition increase the current angle
			current += fraction
		}

	}

	var didLayoutView = false

	override func layoutSubviews() {
		super.layoutSubviews()

		if didLayoutView { return }
		didLayoutView = true
		// add this methods can be called more then once
		let wheelTextPadding: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 30 : 40

		// make into a wheel
		layer.cornerRadius = bounds.width / 2

		// layout labels to on the wheel
		for label in spinnerLabels {
			label.centerInSuperview()
			let paddedWidth = frame.width - wheelTextPadding // trailing label padding
			label.widthAnchor.constraint(equalToConstant: paddedWidth).isActive = true
		}

		addWheelDivisionLines()
		addWheelCenterMarker()
	}

	private func addWheelDivisionLines() {
		let fraction = Double(360 / spinnerLabels.count)

		// determine start angle then add custom offset
		// want the line to be between the text so need to divide the slices angle by 2
		// plus 90 is needed for correct alignment of the first view...ideally would improve this logic but it works
		var current: Double = (fraction / 2) + 90

		for _ in spinnerLabels {
			// add a line for each segment of the wheel
			let wheelLine = UIView()
			wheelLine.backgroundColor = UIColor.flatColor.blue.disco
			wheelLine.translatesAutoresizingMaskIntoConstraints = false
			wheelLine.bounds = CGRect(x: 0, y: 0, width: 4, height: bounds.height / 2)
			wheelLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
			wheelLine.center = CGPoint(x: bounds.midX, y: bounds.midY)
			addSubview(wheelLine)

			let rot = deg2rad(current)
			wheelLine.transform = CGAffineTransform(rotationAngle: CGFloat(rot))
			current += fraction
		}
	}

	private func addWheelCenterMarker() {
		let circle = UIView()
		circle.backgroundColor = .white
		circle.frame = .init(origin: .zero, size: .init(width: 12, height: 12))
		circle.layer.cornerRadius = 11
		addSubview(circle)
		circle.centerInSuperview(size: .init(width: 22, height: 22))
	}

	private func sectionLabel(name: String) -> UILabel {
		let fontSize: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 20 : 36
		let label = UILabel(text: name, font: .boldSystemFont(ofSize: fontSize), textColor: .white, textAlignment: .right, numberOfLines: 1)
		label.center = center
		label.frame = CGRect(x: 0, y: frame.height / 2, width: frame.width, height: fontSize)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}

	private func rotate(view: UIView, by angle: Double) {
		let rads = deg2rad(angle)
		view.transform = CGAffineTransform(rotationAngle: CGFloat(rads))
	}

	private func deg2rad(_ number: Double) -> Double {
		return number * .pi / 180
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
