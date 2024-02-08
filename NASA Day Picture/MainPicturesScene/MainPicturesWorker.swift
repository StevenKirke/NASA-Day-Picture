//
//  MainPicturesWorker.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainPicturesWorker: AnyObject {
	func getData()
}

final class MainPicturesWorker: IMainPicturesWorker {

	// MARK: - Initializator
	internal init() { }

	func getData() { }
}
