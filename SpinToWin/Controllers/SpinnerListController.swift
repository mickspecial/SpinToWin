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
		setUpController()
		addButtons()
		loadSpinnerOptionsData()
	}

	// MARK: - Set Up

	private func setUpController() {
		collectionView.backgroundColor = UIColor.flatColor.gray.twinkle
		collectionView.register(OptionCell.self, forCellWithReuseIdentifier: OptionCell.cellID)
		collectionView.dataSource = self
		collectionView.delegate = self
		title = "Spin To Win"
		navigationController?.navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.tintColor = UIColor.flatColor.gray.balticSea
		navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.flatColor.gray.balticSea]
	}

	private func addButtons() {
		// nav bar buttons
		let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addOptionPressed))
		navigationItem.rightBarButtonItem = addBtn

		// floating done pill button
		let spinBtn = UIButton(title: "Done", titleColor: .white, font: .boldSystemFont(ofSize: 24), backgroundColor: UIColor.flatColor.green.emerald, target: self, action: #selector(showSpinner))
		spinBtn.layer.cornerRadius = 30
		collectionView.addSubview(spinBtn)
		spinBtn.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 50, right: 0), size: .init(width: 120, height: 60))
		spinBtn.centerXInSuperview()
	}

	private func loadSpinnerOptionsData() {
		options = ["Option A", "Option B", "Option C"]
		collectionView.reloadData()
	}

	// MARK: - Collection View Methods

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
		presentOptionToDeleteItem(cellData)
	}

	// MARK: - Remove Items

	private func presentOptionToDeleteItem(_ item: String) {
		let alert = UIAlertController(title: "Delete", message: "Remove \(item)", preferredStyle: .alert)
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
			self.deleteItem(item)
		}
		alert.addAction(deleteAction)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		present(alert, animated: true)
	}

	private func deleteItem(_ item: String) {
		print("Delete item from collection")
		var temp = options
		if let index = temp.firstIndex(of: item) {
			temp.remove(at: index)
			options = temp
			collectionView.reloadData()
		} else {
			print("Unable to remove item...")
		}
	}

	// MARK: - Add Items

	@objc private func addOptionPressed() {
		let alert = UIAlertController.textInput(title: "Add", message: "", placeholder: "", confirmButton: "Add") { newItem in
			guard let newItem = newItem else { return }
			self.addItem(newItem)
		}
		present(alert, animated: true)
	}

	private func addItem(_ item: String) {
		print("Add item from collection")
		if item.isEmpty { return }
		options.append(item)
		collectionView.reloadData()
	}

	// MARK: - Spin

	@objc private func showSpinner() {
		print("Tap....")
	}


}
