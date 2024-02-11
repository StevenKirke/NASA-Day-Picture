//
//  DescriptionPictureViewController.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 10.02.2024.
//

//
//  MainPicturesViewController.swift
//  NASA Day Picture
//
//  Created by Steven Kirke on 08.02.2024.
//

import UIKit
import SnapKit

typealias CurrentCard = MainPicturesModel.ViewModel.Card

protocol IDescriptionPictureViewLogic: AnyObject {
	func render(model: MainPicturesModel.ViewModel.Card)
 }

final class DescriptionPictureViewController: UIViewController {

	// MARK: - Public properties

	// MARK: - Dependencies
	var iterator: IDescriptionPictureIterator?
	let customLayout = DescriptionPictureHeaderLayout()
	// MARK: - Private properties
	private lazy var collectionDescriptionView = createCollectionView()
	private var collectionViewLayout = DescriptionPictureHeaderLayout()
	private var modelForView: CurrentCard = CurrentCard(
		title: "",
		photograph: "",
		description: "",
		image: nil
	)
	private var padding: CGFloat = 16
	private var currentHeight: CGFloat = .zero

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
		iterator?.fetchData()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupLayout()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: false)
	}
}

// - MARK: Add UIView in Controler
private extension DescriptionPictureViewController {
	/// Добавление элементов UIView в Controller.
	func addUIView() {
		let views: [UIView] = [collectionDescriptionView]
		views.forEach(view.addSubview)
	}
}

// - MARK: Initialisation configuration
private extension DescriptionPictureViewController {
	/// Настройка UI элементов
	func setupConfiguration() {
		view.backgroundColor = UIColor.clear
		// navigationItem.title = "Контакты"
		let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		navigationController?.navigationBar.titleTextAttributes = textAttributes

		navigationController?.navigationBar.barTintColor = UIColor.black
		navigationController?.navigationBar.isTranslucent = true
		navigationController?.navigationBar.tintColor = UIColor.white

		collectionDescriptionView.backgroundColor = UIColor.black
		collectionDescriptionView.delegate = self
		collectionDescriptionView.dataSource = self

		collectionDescriptionView.register(
			CellPictureView.self,
			forCellWithReuseIdentifier: CellPictureView.identifierID
		)

		collectionDescriptionView.register(
			HeaderForPictureView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: HeaderForPictureView.identifierHeaderID
		)

		self.collectionDescriptionView.register(
			FooterForPicturesView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
			withReuseIdentifier: FooterForPicturesView.identifierHeaderID
		)
	}
}

// - MARK: Initialisation constraint elements.
private extension DescriptionPictureViewController {
	/// Верстка элементов UI.
	/// - Note: Добавление constraints для UIView элементов.
	func setupLayout() {
		collectionDescriptionView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(-100)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.bottom.equalToSuperview()
		}
	}
}

// - MARK: Add Protocol.
extension DescriptionPictureViewController: IDescriptionPictureViewLogic {
	func render(model: MainPicturesModel.ViewModel.Card) {
		self.modelForView = model
		self.currentHeight = calculateHeight(currentText: modelForView.description) + (padding + 2) + 100
		collectionDescriptionView.reloadData()
	}
}

// - MARK: Logic.
private extension DescriptionPictureViewController {

}

// - MARK: Iterator
private extension DescriptionPictureViewController {
	/// Запрос данных в Iterator.
	func getNetwork() {
		iterator?.fetchData()
	}
}

// - MARK: Add CollectionView delegate for managers cell.
extension DescriptionPictureViewController: UICollectionViewDataSource, UICollectionViewDelegate {

	func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		switch kind {
		case UICollectionView.elementKindSectionHeader:
			let headerView = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: HeaderForPictureView.identifierHeaderID,
				for: indexPath
			)
			guard let typedHeaderView = headerView as? HeaderForPictureView else {
				return headerView
			}
				if let data = modelForView.data {
					typedHeaderView.image.image = UIImage(data: data)
				}
			return typedHeaderView
		case UICollectionView.elementKindSectionFooter:
			let footerView = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: FooterForPicturesView.identifierHeaderID,
				for: indexPath
			)
			guard let currentFooter = footerView as? FooterForPicturesView else {
				return footerView
			}
			return currentFooter
		default:
			assert(false, "Unexpected element kind")
		}
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}

	func collectionView(
		_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		let cell = UICollectionViewCell()
		let currentCard = modelForView
		if let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CellPictureView.identifierID,
			for: indexPath
		) as? CellPictureView {
			cell.labelTitle.text = currentCard.photograph
			cell.labelDescription.text = currentCard.description
			return cell
		}
		return cell
	}

//	func scrollViewDidScroll(_ scrollView: UIScrollView) {
//		guard let layout = customLayout as? UICollectionViewFlowLayout else { return }
//		let offsetY = scrollView.contentOffset.y
//
//		layout.sectionHeadersPinToVisibleBounds = offsetY < 0
//	}
}

extension DescriptionPictureViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		referenceSizeForFooterInSection section: Int
	) -> CGSize {
		return .init(width: view.frame.width, height: 0)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return CGSize(width: collectionView.frame.width - (padding * 2), height: collectionView.frame.height)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
	}
}

private extension DescriptionPictureViewController {
	private func calculateHeight(currentText: String) -> CGFloat {
		let attribute: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]
		let attributeText = NSAttributedString(string: currentText, attributes: attribute)
		let constraintBox = CGSize(width: view.frame.width - (padding * 2), height: .greatestFiniteMagnitude)
		let textHeight = attributeText.boundingRect(
			with: constraintBox,
			options: [.usesLineFragmentOrigin,
		   .usesFontLeading],
			context: nil
		).height
		return textHeight
	}
}

// - MARK: Fabric UIElement.
private extension DescriptionPictureViewController {
	func createCollectionView() -> UICollectionView {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: customLayout)
		customLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 200)
		customLayout.scrollDirection = .vertical
		collectionViewLayout.invalidateLayout()

		collectionView.showsHorizontalScrollIndicator = false
		return collectionView
	}
}
