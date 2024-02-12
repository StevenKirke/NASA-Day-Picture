//
//  MainSearchIterator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainSearchIterator: AnyObject {
	func fetchData(text: String)
}

final class MainSearchIterator {

	// MARK: - Dependencies
	var presenter: IMainSearchPresenter?
	var worker: IMainSearchWorker?

	// MARK: - Initializator
	internal init(presenter: IMainSearchPresenter?, worker: IMainSearchWorker?) {
		self.presenter = presenter
		self.worker = worker
	}
}

extension MainSearchIterator: IMainSearchIterator {
	func fetchData(text: String) {
		DispatchQueue.main.async {
			self.worker?.getRequestData(text: text) { response in
				switch response {
				case .success(let model):
					let responseModel = model.map {
						MainSearchViewModel.Request.Collection(title: $0.title, imageURL: $0.imageURL)
					}
					self.presenter?.present(resultResponse: .success(responseModel))
				case .failure(let error):
					self.presenter?.present(resultResponse: .failure(error))
				}
			}
		}
	}
}
