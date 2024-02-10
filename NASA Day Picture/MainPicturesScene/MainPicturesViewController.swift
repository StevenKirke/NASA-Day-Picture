//
//  MainPicturesViewController.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit
import SnapKit

protocol IMainPicturesViewViewLogic: AnyObject {
	func render(viewModel: CollectionsModel)
 }

final class MainPicturesViewController: UIViewController {

	// MARK: - Public properties

	// MARK: - Dependencies
	var iterator: IMainPicturesIterator?

	// MARK: - Private properties
	private lazy var collectionViewPicture = createCollectionView()
	private var modelForDisplay: [MainPicturesModel.ViewModel.Card] = []
	private var countPage: Int = 1
	private var isLoadData: Bool = false

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
		answerLoadData()
	}
}

// - MARK: Add UIView in Controler
private extension MainPicturesViewController {
	/// Добавление элементов UIView в Controller.
	func addUIView() {
		let views: [UIView] = [collectionViewPicture]
		views.forEach(view.addSubview)
	}
}

// - MARK: Initialisation configuration
private extension MainPicturesViewController {
	/// Настройка UI элементов
	func setupConfiguration() {
		navigationController?.setNavigationBarHidden(true, animated: false)
		collectionViewPicture.backgroundColor = UIColor.black
		collectionViewPicture.register(
			CellForCollectionPictures.self,
			forCellWithReuseIdentifier: CellForCollectionPictures.reuseIdentifier
		)
		collectionViewPicture.delegate = self
		collectionViewPicture.dataSource = self
		collectionViewPicture.translatesAutoresizingMaskIntoConstraints = false
	}
}

// - MARK: Initialisation constraint elements.
private extension MainPicturesViewController {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.

	func setupLayout() {
		collectionViewPicture.snp.makeConstraints { make in
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.top.equalToSuperview()
			make.bottom.equalToSuperview()
		}
	}
}

// - MARK: Add CollectionView delegate for managers cell.
extension MainPicturesViewController: UICollectionViewDataSource, UICollectionViewDelegate {

	func collectionView(
		_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath
	) {
		if indexPath.row == modelForDisplay.count - 1 {
			answerLoadData()
		}
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return modelForDisplay.count
	}

	func collectionView(
		_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		let currentData = modelForDisplay[indexPath.item]
		if let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CellForCollectionPictures.reuseIdentifier,
			for: indexPath
		) as? CellForCollectionPictures {
			cell.upLoadImage(imageURL: currentData.image)
			cell.labelTitle.text = currentData.title
			return cell
		}
		return UICollectionViewCell()
	}
}

// - MARK: Add CollectionView delegate for size.
extension MainPicturesViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		var currentFrame = collectionView.frame.width
		if indexPath.item == 0 {
			currentFrame -= 32 // Два padding по 16.
			return CGSize(width: currentFrame, height: currentFrame / 2)
		}
		currentFrame -= 48 // Три padding по 16.
		return CGSize(width: currentFrame / 2, height: currentFrame / 2)
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

// - MARK: Add Protocol.
extension MainPicturesViewController: IMainPicturesViewViewLogic {
	func render(viewModel: CollectionsModel) {
		self.modelForDisplay.append(contentsOf: viewModel.cards)
		print(self.modelForDisplay.count)
		collectionViewPicture.reloadData()
		stopLoad()
	}
}

// - MARK: Logic.
private extension MainPicturesViewController {
	/**
	 Метод проверки на активность загрузки.
	 Если на текущий момент идет загрузка данных, то запрос к сети не осуществляется.
	 */
	func answerLoadData() {
		print(countPage)
		if !isLoadData {
			getNetwork()
			startLoad()
		}
	}

	func startLoad() {
		self.isLoadData = true
	}

	/// Отключение возможности запроса к данным. Добавление 1 page к запрошенным данным.
	func stopLoad() {
		self.isLoadData = false
		self.countPage += 1
	}
}

// - MARK: Iterator
private extension MainPicturesViewController {
	/// Запрос данных в Iterator.
	func getNetwork() {
		iterator?.fetchData(downloadNumber: countPage)
	}
}

// - MARK: Fabric UIElement.
private extension MainPicturesViewController {
	func createCollectionView() -> UICollectionView {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		return collectionView
	}
}
