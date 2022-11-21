//
//  MatchesUIHandler.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit
import FootballCore

final class MatchesUIHandler: CollectionUIHandler {
    // MARK: - Value Types
    typealias ListObject = Match
    // MARK: - Properties
    let collectionView: UICollectionView
    var cellConfiguration: CellConfiguration?
    var dequeueHeaderCellOperation: DequeueCellOperation?
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
}
