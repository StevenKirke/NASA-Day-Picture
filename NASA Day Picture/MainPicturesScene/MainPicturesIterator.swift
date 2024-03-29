//
//  MainPicturesIterator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainPicturesIterator: AnyObject {
	/**
	 Запрос данных.
	 - Warning: Поставлена задержка на 1 сек. Так как указано в ТЗ.
	 */
	func fetchData(downloadNumber: Int)

	func showDescriptionScene(model: MainPicturesModel.ViewModel.Card)
}

final class MainPicturesIterator {

	// MARK: - Dependencies
	var presenter: IMainPicturesPresenter?
	var worker: IMainPicturesWorker?

	// MARK: - Initializator
	internal init(presenter: IMainPicturesPresenter?, worker: IMainPicturesWorker?) {
		self.presenter = presenter
		self.worker = worker
	}
}

extension MainPicturesIterator: IMainPicturesIterator {
	func fetchData(downloadNumber: Int) {
		DispatchQueue.main.async {
			self.worker?.getRequestData(countLoader: downloadNumber) { response in
				switch response {
				case .success(let model):
					self.presenter?.present(resultResponse: .success(model))
				case .failure(let error):
					self.presenter?.present(resultResponse: .failure(error))
				}
			}
		}
	}

	func showDescriptionScene(model: MainPicturesModel.ViewModel.Card) {
		presenter?.presentDescriptionScene(model: model)
	}
}
