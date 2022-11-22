//
//  UIViewController+UIAlertController.swift
//  MainApp
//
//  Created by MyMac on 2022-11-21.
//

import UIKit

public extension UIViewController {
    func presentErrorAlertController(title: String = "Error", message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(
            title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertController.addAction(okAlertAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true)
        }
    }
    func presentAlert(
        withTitle title: String, message: String?, okAlert: String
    ) {
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            let okAlert = UIAlertAction(title: okAlert, style: .default)
            alertController.addAction(okAlert)
            present(alertController, animated: true, completion: nil)
        }
}


