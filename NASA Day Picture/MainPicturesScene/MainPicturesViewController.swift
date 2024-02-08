//
//  MainPicturesViewController.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

protocol IMainPicturesViewViewLogic: AnyObject {
	func render(viewModel: String)
 }

final class MainPicturesViewController: UIViewController {

	// MARK: - Public properties

	// MARK: - Dependencies
	var iterator: IMainPicturesIterator?

	// MARK: - Private properties

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
	func addUIView() { }
}

// - MARK: Initialisation configuration
private extension MainPicturesViewController {
	/// Настройка UI элементов
	func setupConfiguration() {
		view.backgroundColor = UIColor.green
	}
}

// - MARK: Initialisation constraint elements.
private extension MainPicturesViewController {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.
	func setupLayout() {
		NSLayoutConstraint.activate([
		])
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
	func render(viewModel: String) {
		print("viewModel \(viewModel)")
	}
}
