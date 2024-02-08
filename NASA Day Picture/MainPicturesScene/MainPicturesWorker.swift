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
	func getData(entities: @escaping (CatalogDTO) -> Void)
}

final class MainPicturesWorker: IMainPicturesWorker {

	// MARK: - Dependencies
	var networkManager: INetworkManager?
	var decodeJSONManager: IDecodeJsonManager?

	// MARK: - Initializator
	internal init(
		networkManager: INetworkManager?,
		decodeJSONManager: IDecodeJsonManager?

	) {
		self.networkManager = networkManager
		self.decodeJSONManager = decodeJSONManager
	}

	func getData(entities: @escaping (CatalogDTO) -> Void) {
		let urlString = URLS.allPictures(1)
		networkManager?.getData(url: urlString.assembly) { result in
			switch result {
			case .success(let data):
				print("Data \(data)")
			case .failure(let error):
				print("Error - \(error)")
			}
		}
	}
}
