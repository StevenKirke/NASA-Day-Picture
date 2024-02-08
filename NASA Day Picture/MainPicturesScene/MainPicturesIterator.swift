//
//  MainPicturesIterator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainPicturesIterator: AnyObject {
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
		self.presenter?.present()
	}
}
