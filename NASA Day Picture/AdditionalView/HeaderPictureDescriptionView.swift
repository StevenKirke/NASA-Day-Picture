//
//  DescriptionPictureHeaderView.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 12.02.2024.
//

import UIKit
import SnapKit

final class HeaderPictureDescriptionView: UICollectionReusableView {

	// MARK: - Public properties
	static let identifierHeaderID = "descriptionPictureHeaderView"
	lazy var image = createImage()
	var imageData: Data?

	// MARK: - Dependencies

	// MARK: - Private properties
	// private lazy var image = createImage()

	// MARK: - Initializator
	override init(frame: CGRect) {
		super.init(frame: frame)
		addUIView()
		setupConfiguration()
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

// - MARK: Add UIView in Controler
private extension HeaderPictureDescriptionView {
	/// Добавление элементов UIView в Controller.
	func addUIView() {
		addSubview(image)
	}
}

// - MARK: Initialisation configuration
private extension HeaderPictureDescriptionView {
	/// Настройка UI элементов
	func setupConfiguration() {
		backgroundColor = UIColor.black
	}
}

// - MARK: Initialisation constraint elements.
private extension HeaderPictureDescriptionView {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.
	func setupLayout() {
		image.snp.makeConstraints { image in
			image.top.bottom.equalToSuperview()
			image.left.equalToSuperview()
			image.right.equalToSuperview()
		}
	}
}

// - MARK: Fabric UI Element.
private extension HeaderPictureDescriptionView {
	func createImage() -> UIImageView {
		let image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
		let imageView = UIImageView(image: image)
		imageView.tintColor = UIColor.gray
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false

		return imageView
	}
}
