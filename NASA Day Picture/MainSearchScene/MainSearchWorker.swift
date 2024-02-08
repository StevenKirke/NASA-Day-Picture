//
//  MainSearchWorker.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import Foundation

protocol IMainSearchWorker: AnyObject {
	func getData()
}

final class MainSearchWorker: IMainSearchWorker {

	// MARK: - Initializator
	internal init() { }

	func getData() { }
}
