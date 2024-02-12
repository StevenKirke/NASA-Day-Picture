//
//  MainPicturesCoordinator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

/// Обработка действий в Presenter, переход на следующий экран и показ ошибки в модальном окне.
protocol IMainPictureDelegate: AnyObject {

	/// Запуск экрана описание c картинками.
	func showMainPicturesScene()
	/// Запуск экрана описание новости.
	func showPictureDescriptionScene(model: MainPicturesModel.ViewModel.Card)
	/**
	 Запуск экрана предупреждения, UIAlert.
	 - Parameters:
			- massage: Описание ошибки.
	 */
	func showAlertScene(massage: String)
}

final class MainPicturesCoordinator: ICoordinator, IMainPictureDelegate {

	// MARK: - Public properties
	var childCoordinators: [ICoordinator] = []

	// MARK: - Private properties
	private var navigationController: UINavigationController

	// MARK: - Initializator
	internal init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Public methods
	func start() {
		showMainPicturesScene()
	}

	func showMainPicturesScene() {
		let assembler = MainPicturesAssembler()
		let viewController = assembler.configurator(delegate: self)
		navigationController.pushViewController(viewController, animated: true)
	}

	func showPictureDescriptionScene(model: MainPicturesModel.ViewModel.Card) {
		let assembler = DescriptionPictureAssembler()
		let viewController = assembler.configurator(render: model)
		navigationController.pushViewController(viewController, animated: true)
	}

	func showAlertScene(massage: String) {
		let alertView = createAlert(massage: massage)
		navigationController.present(alertView, animated: true)
	}

	// MARK: - Private methods
}

private extension MainPicturesCoordinator {
	func createAlert(massage: String) -> UIAlertController {
		let alertVC = UIAlertController(title: "Ошибка", message: massage, preferredStyle: .alert)
		alertVC.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
		return alertVC
	}
}
