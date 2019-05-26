//
//  SpinnerListController.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import UIKit

class SpinnerListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

	var options = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.backgroundColor = .white
		collectionView.register(OptionCell.self, forCellWithReuseIdentifier: OptionCell.cellID)
		collectionView.dataSource = self
		collectionView.delegate = self
		setUpController()
		loadSpinnerOptionsData()
	}

	private func setUpController() {
		title = "Spin To Win"
		navigationController?.navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
	}

	private func loadSpinnerOptionsData() {
		options = ["A", "B", "C"]
		collectionView.reloadData()
	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return options.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCell.cellID, for: indexPath) as! OptionCell
		let cellData = options[indexPath.item]
		cell.option = cellData
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width - 20, height: 60)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 10, left: 0, bottom: 10, right: 0)
	}

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let cellData = options[indexPath.item]
		print("Tapped \(cellData)")
	}
}
