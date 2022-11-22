//
//  MatchesUIHandler.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit
import FootballCore
import AVKit

public final class MatchesUIHandler: CollectionUIHandler<Match> {
    private let playerViewController = AVPlayerViewController()
    private func playHighlights(match: Match, from viewController: UIViewController) {
        guard let highlightsURL = match.highlights else { return }
        let player = AVPlayer(url: highlightsURL)
        playerViewController.player = player
        viewController.present(playerViewController, animated: true)
    }
}
