//
//  TriangleView.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import UIKit

class TriangleView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		backgroundColor = .clear
	}

	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }
		context.beginPath()
		context.move(to: CGPoint(x: rect.minX, y: rect.midY))
		context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
		context.closePath()
		context.setFillColor(UIColor.flatColor.red.cinnabar.cgColor)
		context.fillPath()
	}
}
