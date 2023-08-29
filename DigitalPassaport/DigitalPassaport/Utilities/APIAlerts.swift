//
//  APIAlerts.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Foundation
import UIKit

class APIAlerts {
    static func showAPIErrorAlert(on viewController: UIViewController) {
        let title = NSLocalizedString("error title", comment: "")
        let message = NSLocalizedString("server error", comment: "")

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
