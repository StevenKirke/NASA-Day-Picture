//
//  CellForCollectionPictures.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 09.02.2024.
//

import UIKit
import SnapKit

final class CellForCollectionPictures: UICollectionViewCell {

	// MARK: - Public properties
	static let reuseIdentifier = "CellForCollectionPictures.cell"
	lazy var labelTitle = createUILabel()
	// MARK: - Dependencies

	// MARK: - Private properties
	private lazy var imageBackground = createImage()
	private lazy var indicatorView = createIndicator()
	private var isLoadImage: Bool = false

	// MARK: - Initializator
	override init(frame: CGRect) {
		super.init(frame: frame)
		addUIView()
		setupConfiguration()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// MARK: - Lifecycle

	// MARK: - Public methods
	func upLoadImage(imageURL: URL?) {
		self.indicatorView.startAnimating()
		guard let currentURL = imageURL else { return }
		self.loadImage(url: currentURL) { image in
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				self.indicatorView.stopAnimating()
				self.indicatorView.isHidden = true
				self.imageBackground.image = image
			}
		}
	}
	// MARK: - Private methods

}

// - MARK: Add UIView in Controler
private extension CellForCollectionPictures {
	/// Добавление элементов UIView в Controller.
	func addUIView() {
		let views: [UIView] = [indicatorView, imageBackground, labelTitle]
		views.forEach(contentView.addSubview)
	}
}

// - MARK: Initialisation configuration
private extension CellForCollectionPictures {
	/// Настройка UI элементов
	func setupConfiguration() {
		imageBackground.clipsToBounds = true
		imageBackground.contentMode = .scaleAspectFill

		labelTitle.textColor = UIColor.white
		labelTitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		labelTitle.font = UIFont(name: "CeraRoundPro-Medium", size: 18)
		labelTitle.textAlignment = .center
		labelTitle.numberOfLines = 2

		indicatorView.color = UIColor.white
	}
}

// - MARK: Initialisation constraint elements.
private extension CellForCollectionPictures {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.
	func setupLayout() {

		imageBackground.snp.makeConstraints { image in
			image.top.equalToSuperview()
			image.bottom.equalToSuperview()
			image.left.equalToSuperview()
			image.right.equalToSuperview()
		}

		indicatorView.snp.makeConstraints { indicator in
			indicator.top.equalToSuperview()
			indicator.bottom.equalToSuperview()
			indicator.left.equalToSuperview()
			indicator.right.equalToSuperview()
		}

		labelTitle.snp.makeConstraints { label in
			label.bottom.equalToSuperview().inset(10)
			label.left.equalToSuperview().inset(10)
			label.right.equalToSuperview().inset(10)
		}
	}
}

// - MARK: Fabric UI Element.
private extension CellForCollectionPictures {
	func createUILabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}

	func createImage() -> UIImageView {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 12
		imageView.clipsToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false

		return imageView
	}

	func createIndicator() -> UIActivityIndicatorView {
		let indicator = UIActivityIndicatorView()
		indicator.style = .large

		return indicator
	}
}

extension CellForCollectionPictures {
	func loadImage(url: URL, completion: @escaping ((UIImage) -> Void)) {
		URLSession.shared.dataTask(with: url) { data, _, _ in
			var image = UIImage(named: "Images/perseveranceRover")
			if let data = data {
				image = UIImage(data: data)
			}
			if let currentImage = image {
				completion(currentImage)
			}
		}.resume()
	}
}
