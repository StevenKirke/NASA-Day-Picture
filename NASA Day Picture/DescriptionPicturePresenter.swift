//
//  DescriptionPicturePresenter.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 10.02.2024.
//

import Foundation

protocol IDescriptionPicturePresenter: AnyObject {
	/// Метод открывающий ContactListViewController.
	func present(model: MainPicturesModel.ViewModel.Card)
}

final class DescriptionPicturePresenter {

	// MARK: - Public properties

	// MARK: - Dependencies
	private weak var viewController: IDescriptionPictureViewLogic?

	// MARK: - Private properties

	// MARK: - Initializator
	internal init(viewController: IDescriptionPictureViewLogic?) {
		self.viewController = viewController
	}
}

extension DescriptionPicturePresenter: IDescriptionPicturePresenter {
	func present(model: MainPicturesModel.ViewModel.Card) {
		viewController?.render(model: model)
	}
}
