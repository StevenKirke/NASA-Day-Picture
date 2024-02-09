//
//  MainPicturesAssembler.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

final class MainPicturesAssembler {
	func configurator(delegate: IMainPictureDelegate) -> UIViewController {
		let networkManager = NetworkManager()
		let decodeGSONManager = DecodeJsonManager()
		let convectorDTO = ConvertService()
		let worker = MainPicturesWorker(
			networkManager: networkManager,
			decodeJSONManager: decodeGSONManager,
			converterService: convectorDTO
		)
		let viewController = MainPicturesViewController()
		let presenter = MainPicturesPresenter(
			viewController: viewController,
			mainPictureDelegate: delegate
		)
		let iterator = MainPicturesIterator(presenter: presenter, worker: worker)

		viewController.iterator = iterator

		return viewController
	}
}
