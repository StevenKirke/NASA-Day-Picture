//
//  MainSearchViewController.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit

protocol IMainSearchViewViewLogic: AnyObject {
	func render(viewModel: MainSearchViewModel.ViewModel.Cards)
 }

final class MainSearchViewController: UIViewController {

	// MARK: - Public properties

	// MARK: - Dependencies
	var iterator: IMainSearchIterator?

	// MARK: - Private properties
	private let searchController = UISearchController()
	private lazy var collectionViewSearch = createCollectionView()
	private var modelForDisplay: [MainSearchViewModel.ViewModel.Card] = []
	// MARK: - Initializator
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	// MARK: - Public methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setupConfiguration()
		addUIView()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupLayout()
	}
}

// - MARK: Add UIView in Controler
private extension MainSearchViewController {
	/// Добавление элементов UIView в Controller.
	func addUIView() {
		let views: [UIView] = [collectionViewSearch]
		views.forEach(view.addSubview)
	}
}

// - MARK: Initialisation configuration
private extension MainSearchViewController {
	/// Настройка UI элементов
	func setupConfiguration() {
		view.backgroundColor = UIColor.black
		settingNavigationBar()

		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.searchBar.searchTextField.backgroundColor = UIColor.gray
		searchController.searchBar.searchTextField.textColor = UIColor.white

		collectionViewSearch.backgroundColor = UIColor.black
		collectionViewSearch.register(
			CellForCollectionSearch.self,
			forCellWithReuseIdentifier: CellForCollectionSearch.reuseIdentifier
		)
		collectionViewSearch.delegate = self
		collectionViewSearch.dataSource = self
		collectionViewSearch.translatesAutoresizingMaskIntoConstraints = false
	}
}

// - MARK: Setup NavigationBar.
private extension MainSearchViewController {
	func settingNavigationBar() {
		navigationController?.navigationBar.barTintColor = UIColor.black
		navigationController?.navigationBar.isTranslucent = true

		navigationItem.searchController = searchController
		navigationItem.searchController?.searchBar.placeholder = "Найти"
		navigationItem.searchController?.searchBar.tintColor = UIColor.white
	}
}

// - MARK: Initialisation constraint elements.
private extension MainSearchViewController {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.
	func setupLayout() {
		collectionViewSearch.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(0)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
	}
}

// - MARK: Add CollectionView delegate for managers cell.
extension MainSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return modelForDisplay.count
	}

	func collectionView(
		_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		let currentData = modelForDisplay[indexPath.item]
		if let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CellForCollectionSearch.reuseIdentifier,
			for: indexPath
		) as? CellForCollectionSearch {
			 cell.indexPath = indexPath.item
			if let url = currentData.image {
				 cell.downloadImage(imageURL: url)
			}
			 cell.labelTitle.text = currentData.title
			return cell
		}
		return UICollectionViewCell()
	}
}

// - MARK: Add CollectionView delegate for size.
extension MainSearchViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let currentFrame = collectionView.frame.width
		return CGSize(width: currentFrame - 32, height: currentFrame / 2)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		return 16
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
	}
}

// - MARK: Fabric UIElement.
private extension MainSearchViewController {
	func createCollectionView() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		return collectionView
	}
}

// - MARK: ADD Protocol UISearchResultsUpdating.
extension MainSearchViewController: IMainSearchViewViewLogic {
	func render(viewModel: MainSearchViewModel.ViewModel.Cards) {
		self.modelForDisplay = viewModel.cards
		collectionViewSearch.reloadData()
	}
}

// - MARK: Protocol
extension MainSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
	func updateSearchResults(for searchController: UISearchController) { }

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchController.searchBar.text else { return }
		iterator?.fetchData(text: text)
	}
}
