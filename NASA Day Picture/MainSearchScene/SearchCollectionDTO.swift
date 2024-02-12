//
//  SearchCollectionDTO.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 12.02.2024.
//
// swiftlint:disable all
import Foundation

// MARK: - SearchCollection
struct SearchCollectionDTO: Decodable {
	let collection: SearchCatalog
}

// MARK: - Collection
struct SearchCatalog: Decodable {
	let version: String?
	let href: String?
	let items: [ItemDTO]?
	let metadata: MetadataDTO?
	let links: [CollectionLink]?
}

// MARK: - Item
struct ItemDTO: Decodable {
	let href: String?
	let data: [DatumDTO]?
	let links: [ItemLink]?
}

// MARK: - Datum
struct DatumDTO: Decodable {
	let description, title: String
	let photographer: PhotographerDTO?
	let location: LocationDTO?
	let nasaID: String
	let dateCreated: Date
	let keywords: [String]
	let mediaType: MediaType
	let center: Center
	let album: [String]?
	let description508, secondaryCreator: String?

	enum CodingKeys: String, CodingKey {
		case description, title, photographer, location
		case nasaID = "nasa_id"
		case dateCreated = "date_created"
		case keywords
		case mediaType = "media_type"
		case center, album
		case description508 = "description_508"
		case secondaryCreator = "secondary_creator"
	}
}

enum CenterDTO: String, Codable {
	case hq = "HQ"
	case jpl = "JPL"
	case jsc = "JSC"
}

enum LocationDTO: String, Codable {
	case jetPropulsionLaboratoryMars = "Jet Propulsion Laboratory/Mars"
	case jetPropulsionLaboratoryPasadenaCA = "Jet Propulsion Laboratory, Pasadena, CA"
	case jezeroCraterMars = "Jezero Crater, Mars"
	case jplPasadenaCalifornia = "JPL - Pasadena, California"
	case marsPAUSA = "Mars, PA, USA"
}

enum MediaTypeDTO: String, Codable {
	case audio = "audio"
	case image = "image"
	case video = "video"
}

enum PhotographerDTO: String, Codable {
	case nasaBillIngalls = "NASA/Bill Ingalls"
}

// MARK: - ItemLink
struct ItemLinkDTO: Codable {
	let href: String
	let rel: Rel
	let render: MediaTypeDTO?
}

enum RelTDO: String, Codable {
	case captions = "captions"
	case preview = "preview"
}

// MARK: - CollectionLink
struct CollectionLinkDTO: Codable {
	let rel, prompt: String
	let href: String
}

// MARK: - Metadata
struct MetadataDTO: Codable {
	let totalHits: Int

	enum CodingKeys: String, CodingKey {
		case totalHits = "total_hits"
	}
}
// swiftlint:enable all
