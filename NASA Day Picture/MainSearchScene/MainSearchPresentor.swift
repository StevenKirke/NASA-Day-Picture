//
//  MainSearchPresenter.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainSearchPresenter: AnyObject {
	/// Метод открывающий ContactListViewController.
	func present()
}

final class MainSearchPresenter {
	// MARK: - Dependencies
	private weak var viewController: IMainSearchViewViewLogic?

	// MARK: - Private properties

	// MARK: - Initializator
	internal init(viewController: IMainSearchViewViewLogic?) {
		self.viewController = viewController
	}
}

extension MainSearchPresenter: IMainSearchPresenter {
	func present() {
		viewController?.render(viewModel: "Done!")
	}
}
