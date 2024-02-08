//
//  URLS.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

enum URLS {
	case allPictures(Int)
	case search(String)

	var assembly: String {
		var url = ""
		switch self {
		case .allPictures(let page):
			url = "http://images-api.nasa.gov/search?q=all&page=\(page)"
		case .search(let text):
			url = "https://images-api.nasa.gov/search?q=\(text)"
		}
		return url
	}
}
