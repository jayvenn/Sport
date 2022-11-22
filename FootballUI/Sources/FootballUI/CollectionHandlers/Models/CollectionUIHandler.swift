//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import UIKit
import Combine

public class CollectionUIHandler<ListObject: Hashable>: CollectionUILoadable {
    // MARK: - Properties
    public let collectionView: UICollectionView
    public var cellConfiguration: CellConfiguration?
    public var dequeueHeaderCellOperation: DequeueCellOperation?
    private(set) var hashableObjects = CurrentValueSubject<[ListObject], Never>([])
    private(set) var errorMessage = PassthroughSubject<String, Never>()
    private var anyCancellables = Set<AnyCancellable>()
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
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    // MARK: - Data Source
    public func applyDataSourceSnapshot(animatingDifferences: Bool = true) {
        applyDataSourceSnapshot(hashableObjects: hashableObjects.value, animatingDifferences: animatingDifferences)
    }
    public func applyDataSourceSnapshot(hashableObjects: [ListObject], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([""])
        snapshot.appendItems(hashableObjects)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    // MARK: - Subscription
    public func sinkDefaultObjects(viewController: UIViewController) {
        sinkErrorMessage(viewController: viewController)
        sinkHashableObjects(viewController: viewController)
    }
    private func sinkErrorMessage(viewController: UIViewController) {
        errorMessage
            .receive(on: DispatchQueue.main)
            .sink { errorMessage in
                viewController.presentErrorAlertController(message: errorMessage)
            }
            .store(in: &anyCancellables)
    }
    private func sinkHashableObjects(viewController: UIViewController) {
        hashableObjects
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyDataSourceSnapshot()
            }
            .store(in: &anyCancellables)
    }
}
