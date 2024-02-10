//
//  CellPictureView.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 10.02.2024.
//

import UIKit
import SnapKit

// swiftlint:disable all

let text = """
This panoramic view encompasses the entire sky as seen by Two Micron All-Sky Survey. The measured brightnesses of half a billion stars (points) have been combined into colors representing three distinct wavelengths of infrared light: blue at 1.2 microns, green at 1.6 microns, and red at 2.2 microns. This image is centered on the core of our own Milky Way galaxy, toward the constellation of Sagittarius. The reddish stars seemingly hovering in the middle of the Milky Way's disc -- many of them never observed before -- trace the densest dust clouds in our galaxy. The two faint smudges seen in the lower right quadrant are our neighboring galaxies, the Small and Large Magellanic Clouds.  http://photojournal.jpl.nasa.gov/catalog/PIA04250
This panoramic view encompasses the entire sky as seen by Two Micron All-Sky Survey. The measured brightnesses of half a billion stars (points) have been combined into colors representing three distinct wavelengths of infrared light: blue at 1.2 microns, green at 1.6 microns, and red at 2.2 microns. This image is centered on the core of our own Milky Way galaxy, toward the constellation of Sagittarius. The reddish stars seemingly hovering in the middle of the Milky Way's disc -- many of them never observed before -- trace the densest dust clouds in our galaxy. The two faint smudges seen in the lower right quadrant are our neighboring galaxies, the Small and Large Magellanic Clouds.  http://photojournal.jpl.nasa.gov/catalog/PIA04250

"""
// swiftlint:enable all

final class CellPictureView: UICollectionViewCell {

	// MARK: - Public properties
	static let identifierID = "CellPictureView.cell"
	lazy var labelTitle = createUILabel()
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
		let views: [UIView] = [labelTitle]
		views.forEach(contentView.addSubview)
	}
}

// - MARK: Initialisation configuration
private extension CellPictureView {
	/// Настройка UI элементов
	func setupConfiguration() {
		backgroundColor = UIColor.clear

		labelTitle.textColor = UIColor.white
		labelTitle.font = UIFont.systemFont(ofSize: 20, weight: .regular)
		labelTitle.textAlignment = .left
		labelTitle.text = text
	}
}

// - MARK: Initialisation constraint elements.
private extension CellPictureView {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.
	func setupLayout() {
		labelTitle.snp.makeConstraints { label in
			label.top.bottom.equalToSuperview().inset(16)
			label.left.right.equalToSuperview().inset(0)
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
