//
//  MainSearchViewModel.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

// swiftlint:disable nesting
enum MainSearchViewModel {

	enum Response { }

	enum Request {
		case success([MainSearchViewModel.Request.Collection])
		case failure(Error)

		struct Collection {
			let title: String
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
			let image: URL?
		}
	}
}
// swiftlint:enable nesting

extension MainSearchViewModel.Request.Collection {
	init(from: Datum, link: ItemLink) {
		self.init(
			title: from.title,
			imageURL: link.href
		)
	}
}

extension MainSearchViewModel.ViewModel.Cards {
	init(from: [MainSearchViewModel.Request.Collection]) {
		let cards = from.map {
			MainSearchViewModel.ViewModel.Card(from: $0)
		}
		self.init(cards: cards)
	}
}

extension MainSearchViewModel.ViewModel.Card {
	init(from: MainSearchViewModel.Request.Collection) {
		self.init(
			title: from.title,
			image: URL(string: from.imageURL)
		)
	}
}
