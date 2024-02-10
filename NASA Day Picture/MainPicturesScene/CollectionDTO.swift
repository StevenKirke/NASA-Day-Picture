//
//  CollectionDTO.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

// MARK: - CollectionDTO
// swiftlint:disable all
struct CollectionDTO: Decodable {
	let collection: CollectionClass
}

// MARK: - CollectionClass
struct CollectionClass: Decodable {
	let version: String
	let href: String
	let items: [Item]
	let metadata: Metadata
	let links: [CollectionLink]
}

// MARK: - Item
struct Item: Decodable {
	let href: String
	let data: [Datum]
	let links: [ItemLink]?
}

// MARK: - Datum
struct Datum: Codable {
	let center: String?
	let title: String
	let nasaID: String
	let dateCreated: String?
	let keywords: [String]?
	let mediaType: MediaType
	let description508: String?
	let secondaryCreator: String?
	let description: String?
	let photographer: String?
	let location: String?
	let album: [String]?

	enum CodingKeys: String, CodingKey {
		case center
		case title
		case nasaID = "nasa_id"
		case dateCreated = "date_created"
		case keywords
		case mediaType = "media_type"
		case description508 = "description_508"
		case secondaryCreator = "secondary_creator"
		case description, photographer, location, album
	}
}

enum Center: String, Codable {
	case afrc = "AFRC"
	case arc = "ARC"
	case grc = "GRC"
	case gsfc = "GSFC"
	case hq = "HQ"
	case jpl = "JPL"
	case jsc = "JSC"
	case msfc = "MSFC"
	case ssc = "SSC"
}

enum MediaType: String, Codable {
	case audio = "audio"
	case image = "image"
	case video = "video"
}

// MARK: - ItemLink
struct ItemLink: Codable {
	let href: String
	let rel: Rel
	let render: MediaType?
}

enum Rel: String, Codable {
	case captions = "captions"
	case preview = "preview"
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
	let rel, prompt: String
	let href: String
}

// MARK: - Metadata
struct Metadata: Codable {
	let totalHits: Int

	enum CodingKeys: String, CodingKey {
		case totalHits = "total_hits"
	}
}
// swiftlint:enable all
