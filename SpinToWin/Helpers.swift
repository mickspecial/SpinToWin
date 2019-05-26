//
//  Helpers.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import UIKit

extension UILabel {

	convenience init(text: String, font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
		self.init()
		self.text = text
		self.font = font
		self.textColor = textColor
		self.textAlignment = textAlignment
		self.numberOfLines = numberOfLines
	}
}

extension UIButton {

	convenience public init(title: String, titleColor: UIColor, font: UIFont = .systemFont(ofSize: 16), backgroundColor: UIColor = .clear, target: Any? = nil, action: Selector? = nil) {
		self.init(type: .system)
		setTitle(title, for: .normal)
		setTitleColor(titleColor, for: .normal)
		self.titleLabel?.font = font

		self.backgroundColor = backgroundColor
		if let action = action {
			addTarget(target, action: action, for: .touchUpInside)
		}
	}
}


extension UIAlertController {

	static func textInput(title: String, message: String, placeholder: String, confirmButton: String, completion:@escaping (String?) -> Void) -> UIAlertController {
		let composeAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		composeAlert.addTextField { textField in
			textField.placeholder = placeholder
		}
		composeAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		composeAlert.addAction(UIAlertAction(title: confirmButton, style: .default, handler: { _ in
			if let inputString = composeAlert.textFields?.first?.text {
				completion(inputString)
			} else {
				completion(nil)
			}
		}))
		return composeAlert
	}
}


// Helpers I use - I did not create: https://youtu.be/iqpAP7s3b-8
extension UIView {

	@discardableResult
	func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {

		translatesAutoresizingMaskIntoConstraints = false
		var anchoredConstraints = AnchoredConstraints()

		if let top = top {
			anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
		}

		if let leading = leading {
			anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
		}

		if let bottom = bottom {
			anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
		}

		if let trailing = trailing {
			anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
		}

		if size.width != 0 {
			anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
		}

		if size.height != 0 {
			anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
		}

		[anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach { $0?.isActive = true }

		return anchoredConstraints
	}

	func fillSuperview(padding: UIEdgeInsets = .zero) {
		translatesAutoresizingMaskIntoConstraints = false
		if let superviewTopAnchor = superview?.topAnchor {
			topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
		}

		if let superviewBottomAnchor = superview?.bottomAnchor {
			bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
		}

		if let superviewLeadingAnchor = superview?.leadingAnchor {
			leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
		}

		if let superviewTrailingAnchor = superview?.trailingAnchor {
			trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
		}
	}

	func centerInSuperview(size: CGSize = .zero) {
		translatesAutoresizingMaskIntoConstraints = false
		if let superviewCenterXAnchor = superview?.centerXAnchor {
			centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
		}

		if let superviewCenterYAnchor = superview?.centerYAnchor {
			centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
		}

		if size.width != 0 {
			widthAnchor.constraint(equalToConstant: size.width).isActive = true
		}

		if size.height != 0 {
			heightAnchor.constraint(equalToConstant: size.height).isActive = true
		}
	}

	func centerXInSuperview() {
		translatesAutoresizingMaskIntoConstraints = false
		if let superViewCenterXAnchor = superview?.centerXAnchor {
			centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
		}
	}

	func centerYInSuperview() {
		translatesAutoresizingMaskIntoConstraints = false
		if let centerY = superview?.centerYAnchor {
			centerYAnchor.constraint(equalTo: centerY).isActive = true
		}
	}

	func constrainWidth(constant: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		widthAnchor.constraint(equalToConstant: constant).isActive = true
	}

	func constrainHeight(constant: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: constant).isActive = true
	}
}

struct AnchoredConstraints {
	var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UICollectionViewCell {
	static var cellID: String {
		return String(describing: self)
	}
}

extension UIColor {

	convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
		assert(r >= 0 && r <= 255, "Invalid red component")
		assert(g >= 0 && g <= 255, "Invalid green component")
		assert(b >= 0 && b <= 255, "Invalid blue component")
		self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
	}

	convenience init(netHex: Int) {
		self.init(r: (netHex >> 16) & 0xff, g: (netHex >> 8) & 0xff, b: netHex & 0xff)
	}

	enum flatColor {

		enum green {
			static let emerald = UIColor(netHex: 0x2ecc71)
		}

		enum gray {
			static let twinkle = UIColor(netHex: 0xd1d8e0)
			static let balticSea = UIColor(netHex: 0x3d3d3d)
		}

		enum blue {
			static let mariner = UIColor(netHex: 0x3585C5)
			static let disco = UIColor(netHex: 0x25CCF7)
			static let shipsOfficer = UIColor(netHex: 0x2C3A47)
		}

		enum red {
			static let cinnabar = UIColor(netHex: 0xDC5047)
		}
	}
}
