//
//  IConfigurator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

protocol IConfigurator: AnyObject {
	/// Сборщик сцены VIP, подключение Iterator, Presenter, менеджеров сети и других зависимостей.
	func configurator() -> UIViewController
}
