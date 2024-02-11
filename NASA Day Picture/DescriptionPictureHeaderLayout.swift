//
//  DescriptionPictureHeaderLayout.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 11.02.2024.
//

import UIKit

final class DescriptionPictureHeaderLayout: UICollectionViewFlowLayout {

	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		let layoutAttributes = super.layoutAttributesForElements(in: rect)

		layoutAttributes?.forEach { (attributes) in
			if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
				guard let currentCollectionView = collectionView else { return }

				let contentOffsetY = currentCollectionView.contentOffset.y
				let width = currentCollectionView.frame.width
				let currentHeight = attributes.frame.height - contentOffsetY

				attributes.frame = CGRect(x: 0, y: 0, width: width, height: currentHeight)
			}
		}
		return layoutAttributes
	}

	override func shouldInvalidateLayout(
		forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes,
		withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes
	) -> Bool {
		return true
	}
}
