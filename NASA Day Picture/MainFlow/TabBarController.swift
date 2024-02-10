//
//  TabBarController.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

/// Настройки Tab Bar.
final class TabBarController: UITabBarController {

	// MARK: - Public methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setupConfiguration()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		changeHeightTabBar()
	}
}

// - MARK: Initialisation configuration
private extension TabBarController {
	/// Настройка UI элементов
	func setupConfiguration() {
		let controllers: [UINavigationController] = TabBarPage.allTabBarPage.map { getTabController(page: $0) }
		setViewControllers(controllers, animated: true)
		selectedIndex = TabBarPage.firstPage.selectPage
	}

	func getTabController(page: TabBarPage) -> UINavigationController {
		let navController = UINavigationController()
		_ = navController.tabBarController?.tabBar
		tabBar.barTintColor = UIColor.black
		tabBar.tintColor = UIColor.white
		tabBar.isTranslucent = false

		navController.tabBarItem = UITabBarItem(
			title: page.pageTitle(),
			image: page.pageImage(),
			tag: page.selectPage
		)
		return navController
	}

	/// Изменение высоты Tab Bar.
	func changeHeightTabBar() {
		let tabBarHeight: CGFloat = 100
		var tabFrame = tabBar.frame
		tabFrame.size.height = tabBarHeight
		tabFrame.origin.y = view.frame.size.height - tabBarHeight
		tabBar.frame = tabFrame
	}
}
