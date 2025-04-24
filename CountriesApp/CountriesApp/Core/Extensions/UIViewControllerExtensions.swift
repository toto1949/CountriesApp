//
//  UIViewControllerExtensions.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        if actions.isEmpty {
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            actions.forEach { alertController.addAction($0) }
        }
        
        present(alertController, animated: true)
    }
}
