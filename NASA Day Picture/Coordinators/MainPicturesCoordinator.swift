//
//  MainPicturesCoordinator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

final class MainPicturesCoordinator: ICoordinator {

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

	// MARK: - Private methods
	private func showMainPicturesScene() {
		let assembler = MainPicturesAssembler()
		let viewController = assembler.configurator()
		navigationController.pushViewController(viewController, animated: true)
	}
}
