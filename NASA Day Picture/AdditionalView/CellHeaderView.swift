//
//  CellPictureView.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 10.02.2024.
//

import UIKit
import SnapKit

final class CellPictureView: UICollectionViewCell {

	// MARK: - Public properties
	static let identifierID = "CellPictureView.cell"
	lazy var labelTitle = createUILabel()
	lazy var labelDescription = createUILabel()

	// MARK: - Dependencies

	// MARK: - Private properties

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
}

// - MARK: Add UIView in Controler
private extension CellPictureView {
	/// Добавление элементов UIView в Controller.
	func addUIView() {
		let views: [UIView] = [labelTitle, labelDescription]
		views.forEach(contentView.addSubview)
	}
}

// - MARK: Initialisation configuration
private extension CellPictureView {
	/// Настройка UI элементов
	func setupConfiguration() {
		backgroundColor = UIColor.clear
		labelTitle.textColor = UIColor.white
		labelTitle.numberOfLines = 1
		labelTitle.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		labelTitle.textAlignment = .left

		labelDescription.textColor = UIColor.white
		labelDescription.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		labelDescription.textAlignment = .left
	}
}

// - MARK: Initialisation constraint elements.
private extension CellPictureView {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.
	func setupLayout() {
		labelTitle.snp.makeConstraints { title in
			title.top.equalToSuperview().inset(16)
			title.left.right.equalToSuperview().inset(0)
			title.height.equalTo(24)
		}

		labelDescription.snp.makeConstraints { label in
			label.top.equalTo(labelTitle.snp.bottom).inset(-20)
			label.left.right.equalToSuperview()
		}
	}
}

// - MARK: Fabric UI Element.
private extension CellPictureView {
	func createUILabel() -> UILabel {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}
