//
//  MainPicturesPresenter.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainPicturesPresenter: AnyObject {
	/// Метод открывающий ContactListViewController.
	func present()
}

final class MainPicturesPresenter {
	// MARK: - Dependencies
	private weak var viewController: IMainPicturesViewViewLogic?

	// MARK: - Private properties

	// MARK: - Initializator
	internal init(viewController: IMainPicturesViewViewLogic?) {
		self.viewController = viewController
	}
}

extension MainPicturesPresenter: IMainPicturesPresenter {
	func present() {
		viewController?.render(viewModel: "Done!")
	}
}
