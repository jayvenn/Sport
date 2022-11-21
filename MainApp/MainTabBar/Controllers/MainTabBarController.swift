//
//  MainTabBarController.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Overheads
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupChildControllers()
    }
    private func setupChildControllers() {
        viewControllers = [
            makeNavigationController(
                MatchesViewController(),
                title: "Matches",
                image: UIImage(systemName: "flag.2.crossed.circle.fill")!
            ),
            makeNavigationController(
                TeamsViewController(),
                title: "Teams",
                image: UIImage(systemName: "figure.soccer")!
            )
        ]
    }
    private func makeNavigationController(
        _ viewController: UIViewController,
        title: String,
        image: UIImage
    ) -> UINavigationController {
        let navigationController = UINavigationController(
            rootViewController: viewController
        )
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        return navigationController
    }
}
