//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-22.
//

import UIKit
import FootballCore

public final class TeamsUIHandler: CollectionUIHandler<Team> {
    // MARK: - Initializers
    public override init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView)
        cellConfiguration = { cell, team in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = team.name
            cell.contentConfiguration = contentConfiguration
        }
        collectionViewItemAction = { viewController, collectionView, indexPath, hashables in
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
