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
	func fetchData()
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
	func fetchData() {
		DispatchQueue.main.async {
			self.worker?.getRequestData { response in
				switch response {
				case .success(let model):
					self.presenter?.present(resultResponse: .success(model))
				case .failure(let error):
					self.presenter?.present(resultResponse: .failure(error))
				}
			}
		}
	}
}
