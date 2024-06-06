//
//  AlertManager.swift
//  Movie Flix
//
//  Created by sweta makuwala on 06/06/24.
//

import UIKit
class AlertManager {
    static let shared = AlertManager()
    
    func showAlert(title : String?, message : String? , viewController : UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            viewController.present(alert, animated: true)
        }
    }
}
