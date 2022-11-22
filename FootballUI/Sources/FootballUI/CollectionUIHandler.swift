//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import UIKit

protocol CollectionUIHandler: AnyObject {
//    associatedtype ListObject: Hashable
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, String>
    typealias DataSource = UICollectionViewDiffableDataSource<String, String>
    typealias CellConfiguration = (UICollectionViewListCell, String) -> Void
    typealias DequeueCellOperation = (UICollectionView, IndexPath, String) -> UICollectionViewListCell?
    var collectionView: UICollectionView { get }
}
