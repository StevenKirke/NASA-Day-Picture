//
//  MainPicturesViewModel.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

/// Псевдоним для полученных единичного элемента из сети.
typealias CollectionRequest = MainPicturesModel.Request.Collection

/// Псевдоним для полученных данных для ViewModel.
typealias CollectionsModel = MainPicturesModel.ViewModel.Cards

// swiftlint:disable nesting
enum MainPicturesModel {

	enum Response { }

	enum Request {
		case success([Collection])
		case failure(Error)

		struct Collection {
			let title: String
			let photograph: String
			let description: String
			let imageURL: String
		}
	}

	enum ViewModel {
		case success(Cards)
		case failure(Error)

		struct Cards {
			let cards: [Card]
		}

		struct Card {
			let title: String
			let photograph: String
			let description: String
			let image: URL?
		}
	}
}
// swiftlint:enable nesting

extension CollectionRequest {
	init(from: Datum, link: ItemLink) {
		self.init(
			title: from.title,
			photograph: from.photographer ?? "",
			description: from.description ?? "",
			imageURL: link.href)
	}
}

extension MainPicturesModel.ViewModel.Cards {
	init(from: [MainPicturesModel.Request.Collection]) {
		let cards = from.map {
			MainPicturesModel.ViewModel.Card(from: $0)
		}
		self.init(cards: cards)
	}
}

extension MainPicturesModel.ViewModel.Card {
	init(from: MainPicturesModel.Request.Collection) {
		self.init(
			title: from.title,
			photograph: from.photograph,
			description: from.description,
			image: URL(string: from.imageURL)
		)
	}
}
