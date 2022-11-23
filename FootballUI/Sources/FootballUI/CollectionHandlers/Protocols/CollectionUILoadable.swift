//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import UIKit

public protocol CollectionUILoadable: AnyObject {
    associatedtype ListObject: Hashable
    associatedtype Cell: UICollectionViewListCell
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, ListObject>
    typealias DataSource = UICollectionViewDiffableDataSource<String, ListObject>
    typealias CellConfiguration = (Cell, ListObject) -> Void
    typealias DequeueCellOperation = (UICollectionView, IndexPath, ListObject) -> Cell?
    typealias CollectionViewItemAction = (UIViewController, UICollectionView, IndexPath, [ListObject]) -> Void
    var collectionView: UICollectionView { get }
}
