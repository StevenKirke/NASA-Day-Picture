//
//  MainSearchWorker.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainSearchWorker: AnyObject {
	/// Получение данных, сеть, моск, файловая система.
	func getRequestData(
		text: String,
		response: @escaping (Result<[MainSearchViewModel.Request.Collection], Error>) -> Void
	)
}

final class MainSearchWorker: IMainSearchWorker {
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

	func getRequestData(
		text: String,
		response: @escaping (Result<[MainSearchViewModel.Request.Collection], Error>
		) -> Void) {
		let urlString = URLS.search(text).assembly
		networkManager?.getData(url: urlString) { result in
			switch result {
			case .success(let data):
			self.decode(data: data) { resultDecode in
				switch resultDecode {
				case .success(let json):
				if let convert =  self.converterService?.convertForSearch(entity: json) {
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
