//
//  AppHelper.swift
//  HomeTest
//
//  Created by Steven on 8/8/20.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation
import UIKit

class AppHelper {
    static func displayError(title: String, message: String, completion: (() -> Void)? = nil) {
        if let window = UIApplication.shared.windows.first, let rootViewController = window.rootViewController {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            rootViewController.present(alertController, animated: true, completion: completion)
        }
    }
}
