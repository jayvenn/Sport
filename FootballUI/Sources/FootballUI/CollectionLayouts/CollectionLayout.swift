//
//  File.swift
//  
//
//  Created by MyMac on 2022-11-21.
//

import UIKit

public struct ListCollectionLayout {
    public static var defaultCollectionViewLayout: UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment -> NSCollectionLayoutSection? in
            let listConfiguration = UICollectionLayoutListConfiguration(
                appearance: .insetGrouped
            )
            let listCollectionLayoutSection = NSCollectionLayoutSection.list(
                using: listConfiguration, layoutEnvironment: layoutEnvironment
            )
            return listCollectionLayoutSection
        }
        return layout
    }
}
