//
//  OptionCell.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import UIKit

class OptionCell: UICollectionViewCell {

	var option: String = "" {
		didSet {
			optionLabel.text = option
		}
	}

	private var	optionLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .bold), textColor: .white)

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.flatColor.blue.mariner
		layer.cornerRadius = 10
		setUpView()
	}

	private func setUpView() {
		addSubview(optionLabel)
		optionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
