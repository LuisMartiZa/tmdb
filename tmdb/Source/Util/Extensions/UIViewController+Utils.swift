//
//  UIViewController+Utils.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//


import UIKit

extension UIViewController {
    func showAlert(title: String, body: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            completion?()
        }
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
