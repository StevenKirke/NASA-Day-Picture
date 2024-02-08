//
//  NetworkManager.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol INetworkManager {
	func getData(url: String, returnModel: @escaping (Result<Data, ErrorResponse>) -> Void)
}

enum ErrorResponse: Error {
	/// Ошибка, конвертации URL.
	case errorConvertURL
	/// Ошибка, состояния ответа HTTP.
	case errorResponse
	/// Ошибка, запроса HTTP.
	case errorRequest(String)
	/// Пустая Data.
	case errorEmptyData

	var title: String {
		var textError = ""
		switch self {
		case .errorConvertURL:
			textError = "Invalid URL conversion."
		case .errorResponse:
			textError = "Invalid Response received from the server."
		case .errorRequest(let error):
			textError = "Post Request -  \(error)"
		case .errorEmptyData:
			textError = "Nil Data."
		}
		return textError
	}
}

final class NetworkManager: INetworkManager {

	// MARK: - Private properties
	private let task = URLSession.shared

	// MARK: - Public methods
	func getData(url: String, returnModel: @escaping (Result<Data, ErrorResponse>) -> Void) {
		guard let url = URL(string: url) else {
			returnModel(.failure(.errorConvertURL))
			return
		}

		let request = URLRequest(url: url)

		let dataTask = task.dataTask(with: request) { data, response, error in
			DispatchQueue.main.async {
				if let currentError = error {
					returnModel(.failure(.errorRequest(currentError.localizedDescription)))
				}
				if let currentResponse = response as? HTTPURLResponse, (200...299).contains(currentResponse.statusCode) {
					returnModel(.failure(.errorResponse))
				}

				guard let currentData = data else {
					returnModel(.failure(.errorEmptyData))
					return
				}

				returnModel(.success(currentData))
			}
		}
		dataTask.resume()
	}
}
