//
//  MainSearchPresenter.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainSearchPresenter: AnyObject {
	/// Метод открывающий ContactListViewController.
	func present(resultResponse: MainSearchViewModel.Request)
}

final class MainSearchPresenter {
	// MARK: - Dependencies
	private weak var viewController: IMainSearchViewViewLogic?
	var mainSearchDelegate: IMainSearchDelegate?
	// MARK: - Private properties

	// MARK: - Initializator
	internal init(
		viewController: IMainSearchViewViewLogic?,
		mainSearchDelegate: IMainSearchDelegate?
	) {
		self.viewController = viewController
		self.mainSearchDelegate = mainSearchDelegate
	}
}

extension MainSearchPresenter: IMainSearchPresenter {
	func present(resultResponse: MainSearchViewModel.Request) {
		switch resultResponse {
		case .success(let model):
			let viewModel = MainSearchViewModel.ViewModel.Cards(from: model)
			viewController?.render(viewModel: viewModel)
		case .failure(let error):
			mainSearchDelegate?.showAlertScene(massage: error.localizedDescription)
		}
	}
}
