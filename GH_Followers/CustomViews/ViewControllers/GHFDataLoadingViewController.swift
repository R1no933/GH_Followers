//
//  GHFDataLoadingViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 31.08.2022.
//

import UIKit

class GHFDataLoadingViewController: UIViewController {
    //MARK: - Properties
    var containerView: UIView!
    
    //MARK: - Methods
    //Show loading view
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.1) { self.containerView.alpha = 0.7 }
        
        let indicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        indicator.startAnimating()
        
    }
    
    //Dismiss loading view
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    //Show view for users who havn't followers
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GHFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

