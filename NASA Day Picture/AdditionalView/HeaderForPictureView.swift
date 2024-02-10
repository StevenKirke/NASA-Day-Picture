//
//  HeaderForPictureView.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 10.02.2024.
//

import UIKit
import SnapKit

final class HeaderForPictureView: UICollectionReusableView {

	// MARK: - Public properties
	static let identifierHeaderID = "headerForPictureView"
	lazy var image = createImage()
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
private extension HeaderForPictureView {
	/// Добавление элементов UIView в Controller.
	func addUIView() {
		addSubview(image)
	}
}

// - MARK: Initialisation configuration
private extension HeaderForPictureView {
	/// Настройка UI элементов
	func setupConfiguration() {
		backgroundColor = UIColor.red
	}
}

// - MARK: Initialisation constraint elements.
private extension HeaderForPictureView {
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
private extension HeaderForPictureView {
	func createImage() -> UIImageView {
		let image = UIImage(named: "Images/perseveranceRover")
		let imageView = UIImageView(image: image)
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false

		return imageView
	}
}
