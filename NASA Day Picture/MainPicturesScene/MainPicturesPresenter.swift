//
//  MainPicturesPresenter.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainPicturesPresenter: AnyObject {
	/// Метод открывающий ContactListViewController.
	func present(resultResponse: MainPicturesModel.Request)

	func presentDescriptionScene(model: MainPicturesModel.ViewModel.Card)
}

final class MainPicturesPresenter {

	// MARK: - Public properties

	// MARK: - Dependencies
	private weak var viewController: IMainPicturesViewViewLogic?
	private var mainPictureDelegate: IMainPictureDelegate?

	// MARK: - Private properties

	// MARK: - Initializator
	internal init(
		viewController: IMainPicturesViewViewLogic?,
		mainPictureDelegate: IMainPictureDelegate?
	) {
		self.viewController = viewController
		self.mainPictureDelegate = mainPictureDelegate
	}
}

extension MainPicturesPresenter: IMainPicturesPresenter {
	func present(resultResponse: MainPicturesModel.Request) {
		switch resultResponse {
		case .success(let model):
			let viewModel = MainPicturesModel.ViewModel.Cards(from: model)
			viewController?.render(viewModel: viewModel)
		case .failure(let error):
			mainPictureDelegate?.showAlertScene(massage: error.localizedDescription)
		}
	}

	func presentDescriptionScene(model: MainPicturesModel.ViewModel.Card) {
		mainPictureDelegate?.showPictureDescriptionScene(model: model)
	}
}
