//
//  MainSearchIterator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainSearchIterator: AnyObject {
	func fetchData()
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
	func fetchData() {
		self.presenter?.present()
	}
}

