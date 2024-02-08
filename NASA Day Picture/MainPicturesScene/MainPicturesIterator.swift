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
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.worker?.getData(entities: { resultDTO in
				switch resultDTO {
				case .success(let catalogDTO):
					print("catalogDTO - \(catalogDTO)")
				case .failure(let error):
					print("Error - \(error)")
				}
			})
		}
		// self.presenter?.present()
	}
}
