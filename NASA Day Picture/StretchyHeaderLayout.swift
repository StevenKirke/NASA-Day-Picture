//
//  StretchyHeaderLayout.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 12.02.2024.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {

	// we want to modify the attributes for our header component somehow
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		let layoutAttributes = super.layoutAttributesForElements(in: rect)

		layoutAttributes?.forEach({ (attributes) in
			if attributes.representedElementKind == UICollectionView.elementKindSectionHeader
				&& attributes.indexPath.section == 0 {

				guard let collectionView = collectionView else { return }

				let contentOffsetY = collectionView.contentOffset.y

				if contentOffsetY > 0 {
					return
				}

				let width = collectionView.frame.width
				let height = attributes.frame.height - contentOffsetY

				// Header
				attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
			}
		})

		return layoutAttributes
	}

	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		return true
	}
}
