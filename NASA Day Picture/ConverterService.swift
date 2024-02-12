//
//  ConverterService.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IConvertService {
	/// Конвертация данных из JSON в ``MainPicturesModel.Request.Collection``.
	func convert(entity: CollectionDTO) -> [MainPicturesModel.Request.Collection]

	func convertForSearch(entity: CollectionDTO) -> [MainSearchViewModel.Request.Collection]
}

final class ConvertServiceForPictures: IConvertService {
	func convert(entity: CollectionDTO) -> [MainPicturesModel.Request.Collection] {
		var currentCollections: [MainPicturesModel.Request.Collection] = []
		let entities = entity.collection.items
		_ = entities.map { entity in
			if let data = entity.data.first, let link = entity.links?.first {
				let collection = CollectionRequest(from: data, link: link)
				currentCollections.append(collection)
			}
		}
		return currentCollections
	}

	func convertForSearch(entity: CollectionDTO) -> [MainSearchViewModel.Request.Collection] {
		var currentCollections: [MainSearchViewModel.Request.Collection] = []
		let entities = entity.collection.items
		_ = entities.map { entity in
			if let data = entity.data.first, let link = entity.links?.first {
				let collection = MainSearchViewModel.Request.Collection(
					from: data,
					link: link
				)
				currentCollections.append(collection)
			}
		}

		return currentCollections
	}
}
