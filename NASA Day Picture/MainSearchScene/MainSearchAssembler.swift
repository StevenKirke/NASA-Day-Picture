//
//  MainSearchAssembler.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

final class MainSearchAssembler: IConfigurator {
	func configurator() -> UIViewController {
		let worker = MainSearchWorker()
		let viewController = MainSearchViewController()
		let presenter = MainSearchPresenter(viewController: viewController)
		let iterator = MainSearchIterator(presenter: presenter, worker: worker)

		viewController.iterator = iterator

		return viewController
	}
}
