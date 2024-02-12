//
//  MainSearchCoordinator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

protocol IMainSearchDelegate: AnyObject {

	func showSearchScene()

	func showAlertScene(massage: String)
}

final class MainSearchCoordinator: ICoordinator, IMainSearchDelegate {

	// MARK: - Public properties
	var childCoordinators: [ICoordinator] = []

	// MARK: - Dependencies

	// MARK: - Private properties
	private var navigationController: UINavigationController

	// MARK: - Initializator
	internal init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Lifecycle

	// MARK: - Public methods
	func start() {
		showSearchScene()
	}

	// MARK: - Private methods
	func showSearchScene() {
		let assembler = MainSearchAssembler()
		let viewController = assembler.configurator(delegate: self)
		navigationController.pushViewController(viewController, animated: true)
	}

	func showAlertScene(massage: String) {
		let alertView = createAlert(massage: massage)
		navigationController.present(alertView, animated: true)
	}
}

private extension MainSearchCoordinator {
	func createAlert(massage: String) -> UIAlertController {
		let alertVC = UIAlertController(title: "Ошибка", message: massage, preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
		return alertVC
	}
}
