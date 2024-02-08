//
//  MainSearchCoordinator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

final class MainSearchCoordinator: ICoordinator {

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
	private func showSearchScene() {
		let assembler = MainSearchAssembler()
		let viewController = assembler.configurator()
		navigationController.pushViewController(viewController, animated: true)
	}
}
