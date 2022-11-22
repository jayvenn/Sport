//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import UIKit

public protocol CollectionUILoadable: AnyObject {
    associatedtype ListObject: Hashable
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, ListObject>
    typealias DataSource = UICollectionViewDiffableDataSource<String, ListObject>
    typealias CellConfiguration = (UICollectionViewListCell, ListObject) -> Void
    typealias DequeueCellOperation = (UICollectionView, IndexPath, ListObject) -> UICollectionViewListCell?
    var collectionView: UICollectionView { get }
}
