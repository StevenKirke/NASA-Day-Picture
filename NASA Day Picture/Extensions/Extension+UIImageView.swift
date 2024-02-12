//
//  Extension+UIImageView.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 10.02.2024.
//

import UIKit

extension UIImageView {
	func loadImage(url: URL, returnModel: @escaping ((UIImage) -> Void)) {
		DispatchQueue.global().async { [weak self] in
			guard let self = self else { return }
			if let data = try? Data(contentsOf: url) {
				self.convertData(data: data) { responseImage in
					returnModel(responseImage)
				}
			}
		}
	}

	private func convertData(data: Data, responseImage: @escaping ((UIImage) -> Void)) {
		if let image = UIImage(data: data) {
			responseImage(image)
		}
	}
}
