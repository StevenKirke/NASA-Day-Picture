//
//  MainPicturesViewController.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit
import SnapKit

protocol IMainPicturesViewViewLogic: AnyObject {
	func render(viewModel: CollectionsModel)
 }

final class MainPicturesViewController: UIViewController {

	// MARK: - Public properties

	// MARK: - Dependencies
	var iterator: IMainPicturesIterator?

	// MARK: - Private properties
	let labelTest = UILabel()

	// MARK: - Initializator
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	// MARK: - Public methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setupConfiguration()
		addUIView()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupLayout()
		get()
	}
}

// - MARK: Add UIView in Controler
private extension MainPicturesViewController {
	/// Добавление элементов UIView в Controller.
	func addUIView() {
		let views: [UIView] = [labelTest]
		views.forEach(view.addSubview)
	}
}

// - MARK: Initialisation configuration
private extension MainPicturesViewController {
	/// Настройка UI элементов
	func setupConfiguration() {
		view.backgroundColor = UIColor.green
		labelTest.text = "THis is label text"
		labelTest.layer.borderWidth = 1
		labelTest.textAlignment = .center
	}
}

// - MARK: Initialisation constraint elements.
private extension MainPicturesViewController {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.

	func setupLayout() {
		labelTest.snp.makeConstraints { make in
			make.left.equalToSuperview().inset(20)
			make.right.equalToSuperview().inset(20)
			make.top.equalToSuperview().inset(20)
			make.bottom.equalToSuperview().inset(20)
		}
	}
}

// Action
private extension MainPicturesViewController {
	func get() {
		iterator?.fetchData()
	}
}

// - MARK: Add Protocol.
extension MainPicturesViewController: IMainPicturesViewViewLogic {
	func render(viewModel: CollectionsModel) {
		print("viewModel")
	}
}
