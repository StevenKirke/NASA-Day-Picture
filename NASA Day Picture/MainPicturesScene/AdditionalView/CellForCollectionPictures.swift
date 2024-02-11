//
//  CellForCollectionPictures.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 09.02.2024.
//

import UIKit
import SnapKit

protocol ICellForCollectionPicturesHendler {
	func returnDataImage(returnImage: Data?, indexPath: Int)
}

final class CellForCollectionPictures: UICollectionViewCell {

	// MARK: - Public properties
	var indexPath: Int = 0
	static let reuseIdentifier = "CellForCollectionPictures.cell"
	lazy var labelTitle = createUILabel()
	var handlerDelegate: ICellForCollectionPicturesHendler?
	// MARK: - Dependencies

	// MARK: - Private properties
	private lazy var imageBackground = createImage()
	private lazy var indicatorView = createIndicator()
	private var isLoadImage: Bool = false

	// MARK: - Initializator

	convenience init(handlerDelegate: ICellForCollectionPicturesHendler?) {
		self.init(frame: CGRect.zero)
		self.handlerDelegate = handlerDelegate
	}

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
		self.loadImage(url: currentURL) { returnData in
			self.handlerDelegate?.returnDataImage(returnImage: returnData, indexPath: self.indexPath)
			self.indicatorView.stopAnimating()
			self.indicatorView.isHidden = true
		}
	}
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
	func loadImage(url: URL, completion: @escaping ((Data?) -> Void)) {

		let writeURL = url.absoluteString
		self.accessibilityLabel = writeURL

		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let data = data, error == nil,
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let image = UIImage(data: data) else {
				completion(data)
				return
			}

			let currentURL = self.accessibilityLabel
			if writeURL != currentURL {
				completion(data)
				return
			}
			DispatchQueue.main.async {
				self.imageBackground.image = image
				completion(data)
			}
		}.resume()
	}
}
