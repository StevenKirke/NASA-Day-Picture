//
//  MainSearchViewModel.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

enum MainSearchViewModel {

	enum Response { }

	enum Request {
		case success(String)
		case failure(Error)
	}

	enum ViewModel {
		case success(String)
		case failure(Error)
	}
}
