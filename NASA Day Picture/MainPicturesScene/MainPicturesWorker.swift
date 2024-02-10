//
//  MainPicturesWorker.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

typealias CatalogDTO = Result<CollectionDTO, Error>

protocol IMainPicturesWorker: AnyObject {
	/// Получение данных, сеть, моск, файловая система.
	func getRequestData(countLoader: Int, response: @escaping (Result<[CollectionRequest], Error>) -> Void)
}

final class MainPicturesWorker: IMainPicturesWorker {

	// MARK: - Dependencies
	var networkManager: INetworkManager?
	var decodeJSONManager: IDecodeJsonManager?
	var converterService: IConvertService?

	// MARK: - Initializator
	internal init(
		networkManager: INetworkManager?,
		decodeJSONManager: IDecodeJsonManager?,
		converterService: IConvertService?

	) {
		self.networkManager = networkManager
		self.decodeJSONManager = decodeJSONManager
		self.converterService = converterService
	}

	func getRequestData(countLoader: Int, response: @escaping (Result<[CollectionRequest], Error>) -> Void) {
		let urlString = URLS.allPictures(countLoader)
		networkManager?.getData(url: urlString.assembly) { result in
			switch result {
			case .success(let data):
			self.decode(data: data) { resultDecode in
				switch resultDecode {
				case .success(let json):
					if let convert =  self.converterService?.convert(entity: json) {
						response(.success(convert))
					}
				case .failure(let error):
					response(.failure(error))
				}
			}
			case .failure(let error):
				response(.failure(error))
			}
		}
	}

	private func decode(data: Data, responseJSON: @escaping (Result<CollectionDTO, DecodeError>) -> Void ) {
		decodeJSONManager?.decodeJSON(data: data, model: CollectionDTO.self) { result in
			switch result {
			case .success(let json):
				responseJSON(.success(json))
			case .failure(let error):
				responseJSON(.failure(error))
			}
		}
	}
}
