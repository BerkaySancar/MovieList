//
//  UIViewController+Extensions.swift
//  MovieList
//
//  Created by Berkay Sancar on 11.11.2022.
//

import Foundation
import UIKit.UIViewController

extension UIViewController {
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
