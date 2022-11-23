//
//  MatchesUIHandler.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit
import FootballCore
import AVKit

public final class MatchesUIHandler:
    CollectionUIHandler<Match, UICollectionViewListCell>
{
    // MARK: - Properties
    private let playerViewController = AVPlayerViewController()
    // MARK: - Initializers
    public override init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView)
        cellConfiguration = { cell, match in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = match.description
            if match.highlights != nil {
                contentConfiguration.image = UIImage(systemName: "play.circle.fill")
            } else {
                contentConfiguration.image = nil
            }
            cell.contentConfiguration = contentConfiguration
        }
        collectionViewItemAction = { [weak self] viewController, collectionView, indexPath, hashables in
            collectionView.deselectItem(at: indexPath, animated: true)
            self?.playHighlights(
                match: hashables[indexPath.item],
                from: viewController
            )
        }
    }
    // MARK: - Methods
    private func playHighlights(match: Match, from viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            guard
                let self = self,
                let highlightsURL = match.highlights else { return }
            let player = AVPlayer(url: highlightsURL)
            player.play()
            self.playerViewController.player = player
            viewController.present(self.playerViewController, animated: true)
        }
    }
}
