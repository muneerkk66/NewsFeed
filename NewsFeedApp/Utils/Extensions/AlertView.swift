//
//  Extension.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 07/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import Foundation
import UIKit
protocol AlertView {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
}

extension AlertView where Self: UIViewController {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
}

