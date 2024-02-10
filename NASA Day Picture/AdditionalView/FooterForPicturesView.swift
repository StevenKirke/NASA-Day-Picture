//
//  FooterForPicturesView.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 10.02.2024.
//

import UIKit
import SnapKit

final class FooterForPicturesView: UICollectionReusableView {

	// MARK: - Public properties
	static let identifierHeaderID = "footerForPictureView"
	// MARK: - Dependencies

	// MARK: - Private properties

	// MARK: - Initializator
	override init(frame: CGRect) {
		super.init(frame: frame)
		addUIView()
		setupConfiguration()
		setupLayout()
	}

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
	}
}

// - MARK: Add UIView in Controler
private extension FooterForPicturesView {
	/// Добавление элементов UIView в Controller.
	func addUIView() { }
}

// - MARK: Initialisation configuration
private extension FooterForPicturesView {
	/// Настройка UI элементов
	func setupConfiguration() {
		backgroundColor = UIColor.clear
	}
}

// - MARK: Initialisation constraint elements.
private extension FooterForPicturesView {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.
	func setupLayout() { }
}
