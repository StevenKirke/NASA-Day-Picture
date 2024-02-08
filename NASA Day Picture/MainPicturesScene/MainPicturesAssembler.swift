//
//  MainPicturesAssembler.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

final class MainPicturesAssembler: IConfigurator {
	func configurator() -> UIViewController {
		let worker = MainPicturesWorker()
		let viewController = MainPicturesViewController()
		let presenter = MainPicturesPresenter(viewController: viewController)
		let iterator = MainPicturesIterator(presenter: presenter, worker: worker)

		viewController.iterator = iterator

		return viewController
	}
}
