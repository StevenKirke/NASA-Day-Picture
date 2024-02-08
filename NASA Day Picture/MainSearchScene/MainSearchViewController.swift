//
//  MainSearchViewController.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

protocol IMainSearchViewViewLogic: AnyObject {
	func render(viewModel: String)
 }

final class MainSearchViewController: UIViewController {

	// MARK: - Public properties

	// MARK: - Dependencies
	var iterator: IMainSearchIterator?

	// MARK: - Private properties
	private lazy var labelTitle = UILabel()

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
	}
}

// - MARK: Add UIView in Controler
private extension MainSearchViewController {
	/// Добавление элементов UIView в Controller.
	func addUIView() {
		let views: [UIView] = [labelTitle]
		views.forEach(view.addSubview)
	}
}

// - MARK: Initialisation configuration
private extension MainSearchViewController {
	/// Настройка UI элементов
	func setupConfiguration() {
		view.backgroundColor = UIColor.red

		labelTitle.text = "Test"
		labelTitle.layer.borderWidth = 1
		labelTitle.layer.borderColor = UIColor.red.cgColor
		labelTitle.translatesAutoresizingMaskIntoConstraints = false
	}
}

// - MARK: Initialisation constraint elements.
private extension MainSearchViewController {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.
	func setupLayout() {
		NSLayoutConstraint.activate([
			labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			labelTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
}

// - MARK: ADD Protocol.
extension MainSearchViewController: IMainSearchViewViewLogic {
	func render(viewModel: String) {
		print("viewModel \(viewModel)")
	}
}
