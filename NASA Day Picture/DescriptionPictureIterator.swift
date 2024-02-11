//
//  DescriptionPictureIterator.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 10.02.2024.
//

import Foundation

protocol IDescriptionPictureIterator: AnyObject {
	func fetchData()
}

final class DescriptionPictureIterator {

	// MARK: - Dependencies
	var presenter: IDescriptionPicturePresenter?

	let model: MainPicturesModel.ViewModel.Card

	// MARK: - Initializator
	internal init(
		presenter: IDescriptionPicturePresenter?,
		model: MainPicturesModel.ViewModel.Card
	) {
		self.presenter = presenter
		self.model = model
	}
}

extension DescriptionPictureIterator: IDescriptionPictureIterator {
	func fetchData() {
		presenter?.present(model: model)
	}
}
