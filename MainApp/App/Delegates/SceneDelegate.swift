//
//  SceneDelegate.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mainTabBarController = MainTabBarController()
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
    }
}
