//
//  MainCoordinator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies
	private let tabBarController: UITabBarController

	// MARK: - Private properties
	private let pages: [TabBarPage] = TabBarPage.allTabBarPage

	// MARK: - Initialisation
	init(tabBarController: UITabBarController) {
		self.tabBarController = tabBarController
	}

	// MARK: - Internal methods
	override func start() {
		tabBarController.viewControllers?.enumerated().forEach { item in
			guard let controller = item.element as? UINavigationController else { return }
			getTabController(item.offset, on: controller)
		}
	}
}

// MARK: - Run flow.
private extension MainCoordinator {
	/// Запуск потоков меню.
	/// - Parameters:
	///   - index: Индекс из перечисления.
	///   - controller: Текущий UINavigationController.
	func getTabController(_ index: Int, on controller: UINavigationController) {
		let coordinator: ICoordinator
		switch pages[index] {
		case .photos:
			coordinator = MainPicturesCoordinator(navigationController: controller)
		case .search:
			coordinator = MainSearchCoordinator(navigationController: controller)
		}
		addDependency(coordinator)
		coordinator.start()
	}
}

