//
//  UIViewCOntroller+Ext.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GHFAllertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
}
