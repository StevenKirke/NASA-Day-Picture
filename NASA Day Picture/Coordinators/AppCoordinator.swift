//
//  AppCoordinator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies
	private var navigationController: UINavigationController
	private var window: UIWindow?

	// MARK: - Private properties

	// MARK: - Initializator
	internal init(window: UIWindow?) {
		self.window = window
		self.navigationController = UINavigationController()
	}

	// MARK: - Internal methods
	override func start() {
		runMainFlow()
	}

	// MARK: - Public methods
	func runMainFlow() {
		let tabBrController = TabBarController()
		let coordinator = MainCoordinator(tabBarController: tabBrController)
		addDependency(coordinator)
		coordinator.start()

		navigationController.isNavigationBarHidden = true
		navigationController.setViewControllers([tabBrController], animated: true)

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
