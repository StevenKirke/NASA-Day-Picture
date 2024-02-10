//
//  DescriptionPictureAssembler.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 10.02.2024.
//

import UIKit

final class DescriptionPictureAssembler {
	func configurator() -> UIViewController {
		let viewController = DescriptionPictureViewController()
		let presenter = DescriptionPicturePresenter(viewController: viewController)
		let iterator = DescriptionPictureIterator(presenter: presenter)
		viewController.iterator = iterator

		return viewController
	}
}
