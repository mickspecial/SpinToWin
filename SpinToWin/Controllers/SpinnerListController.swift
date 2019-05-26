//
//  SpinnerListController.swift
//  SpinToWin
//
//  Created by Michael Schembri on 26/5/19.
//  Copyright © 2019 Michael Schembri. All rights reserved.
//

import UIKit

class SpinnerListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

	var options = [SpinnerItem]()

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
		title = "Spinner Items"
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
		options.removeAll()
		options = User.current.items
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

	private func presentOptionToDeleteItem(_ item: SpinnerItem) {
		let alert = UIAlertController(title: "Delete", message: "Remove \(item.itemName)", preferredStyle: .alert)
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
			self.deleteItem(item)
		}
		alert.addAction(deleteAction)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		present(alert, animated: true)
	}

	private func deleteItem(_ item: SpinnerItem) {
		print("Delete item from collection")
		var temp = options
		let preDeleteCount = temp.count
		temp.removeAll(where: { $0.id == item.id })
		User.current.items = temp
		loadSpinnerOptionsData()
		User.current.save()
		precondition(User.current.items.count == preDeleteCount - 1, "Delete Error")
	}

	// MARK: - Add Items

	@objc private func addOptionPressed() {

		if options.count == 10 {
			showErrorAlert(message: "Max of 10 options only")
			return
		}

		let alert = UIAlertController.textInput(title: "Add", message: "", placeholder: "", confirmButton: "Add") { newItem in
			guard let newItem = newItem else { return }
			self.addItem(newItem)
		}
		present(alert, animated: true)
	}

	private func addItem(_ item: String) {
		print("Add item to collection")
		if item.isEmpty { return }

		var temp = options
		let preAddCount = temp.count
		temp.append(SpinnerItem(itemName: item))
		User.current.items = temp
		loadSpinnerOptionsData()
		User.current.save()
		precondition(User.current.items.count == preAddCount + 1, "Add Error")
	}

	// MARK: - Spin

	private func showErrorAlert(message: String) {
		let alert = UIAlertController(title: "Opps...", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		present(alert, animated: true)
	}

	@objc private func showSpinner() {
		if options.count < 2 {
			showErrorAlert(message: "At least 2 options needed")
			return
		}

		navigationController?.pushViewController(SpinnerViewController(spinnerItems: options), animated: true)
	}
}
