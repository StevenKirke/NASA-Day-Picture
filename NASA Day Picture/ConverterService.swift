//
//  ConverterService.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IConvertService {
	/// Конвертация данных из JSON в ``MainPicturesModel.Request.Collection``.
	func convert(entity: CollectionDTO) -> [CollectionRequest]
}

final class ConvertService: IConvertService {
	func convert(entity: CollectionDTO) -> [CollectionRequest] {
		var currentCollections: [CollectionRequest] = []
		let entities = entity.collection.items
		_ = entities.map { entity in
			if let data = entity.data.first, let link = entity.links?.first {
				let collection = CollectionRequest(from: data, link: link)
				currentCollections.append(collection)
			}
		}
		return currentCollections
	}
}
