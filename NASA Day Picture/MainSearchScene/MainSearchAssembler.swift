//
//  MainSearchAssembler.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

final class MainSearchAssembler {
	func configurator(delegate: IMainSearchDelegate) -> UIViewController {
		let networkManager = NetworkManager()
		let decodeGSONManager = DecodeJsonManager()
		let convectorDTO = ConvertServiceForPictures()
		let worker = MainSearchWorker(
			networkManager: networkManager,
			decodeJSONManager: decodeGSONManager,
			converterService: convectorDTO
		)
		let viewController = MainSearchViewController()
		let presenter = MainSearchPresenter(
			viewController: viewController,
			mainSearchDelegate: delegate
		)
		let iterator = MainSearchIterator(presenter: presenter, worker: worker)

		viewController.iterator = iterator

		return viewController
	}
}
