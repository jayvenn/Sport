//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import UIKit
import Combine

protocol CollectionUILoadable: AnyObject {
    associatedtype ListObject: Hashable
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, ListObject>
    typealias DataSource = UICollectionViewDiffableDataSource<String, ListObject>
    typealias CellConfiguration = (UICollectionViewListCell, ListObject) -> Void
    typealias DequeueCellOperation = (UICollectionView, IndexPath, ListObject) -> UICollectionViewListCell?
    var collectionView: UICollectionView { get }
}

final class CollectionUIHandler<ListObject: Hashable>: CollectionUILoadable {
    // MARK: - Properties
    let collectionView: UICollectionView
    var cellConfiguration: CellConfiguration?
    var dequeueHeaderCellOperation: DequeueCellOperation?
    private(set) var hashableObjects = CurrentValueSubject<[ListObject], Never>([])
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment -> NSCollectionLayoutSection? in
            var listConfiguration = UICollectionLayoutListConfiguration(
                appearance: .insetGrouped
            )
            let listCollectionLayoutSection = NSCollectionLayoutSection.list(
                using: listConfiguration, layoutEnvironment: layoutEnvironment
            )
            return listCollectionLayoutSection
        }
        return layout
    }()
    lazy var dataSource: DataSource = {
        let listCellRegistration = UICollectionView.CellRegistration
        <UICollectionViewListCell, ListObject> { [weak self] cell, _, object in
            guard let cellConfiguration = self?.cellConfiguration else { return }
            cellConfiguration(cell, object)
        }
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, object in
            guard let dequeueCellOperation = self.dequeueHeaderCellOperation else {
                return collectionView.dequeueConfiguredReusableCell(
                    using: listCellRegistration,
                    for: indexPath,
                    item: object
                )
            }
            return dequeueCellOperation(collectionView, indexPath, object)
        }
        return dataSource
    }()
    // MARK: - Initializers
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    // MARK: - Data Source
    func applyDataSourceSnapshot(animatingDifferences: Bool = true) {
        applyDataSourceSnapshot(hashableObjects: hashableObjects.value, animatingDifferences: animatingDifferences)
    }
    func applyDataSourceSnapshot(hashableObjects: [ListObject], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([""])
        snapshot.appendItems(hashableObjects)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
