//
//  TabBarPage.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

/// Tab Bar
enum TabBarPage {
	case photos
	case search

	/// Выбор страницы.
	var selectPage: Int {
		guard let currentIndex = TabBarPage.allTabBarPage.firstIndex(of: self) else { return .zero}
		return currentIndex
	}
	/// Название для Tab Bar.
	func pageTitle() -> String {
		var title = ""
		switch self {
		case .photos:
			title = "Фото дня"
		case .search:
			title = "Поиск"
		}
		return title
	}
	/// Изображения для Tab Bar.
	func pageImage() -> UIImage {
		var name = ""
		switch self {
		case .photos:
			name = "photo.on.rectangle.angled"
		case .search:
			name = "magnifyingglass"
		}
		return UIImage(systemName: name) ?? .actions
	}

	static let allTabBarPage: [TabBarPage] = [.photos, .search]
	static let firstPage: TabBarPage = .photos
}
