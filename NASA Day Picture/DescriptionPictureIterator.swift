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

	// MARK: - Initializator
	internal init(presenter: IDescriptionPicturePresenter?) {
		self.presenter = presenter
	}
}

extension DescriptionPictureIterator: IDescriptionPictureIterator {
	func fetchData() { }
}
