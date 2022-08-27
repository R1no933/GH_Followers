//
//  FollowerViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    //MARK: - Properties
    var username: String!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print("Followers count = \(followers.count)")
                print(followers)
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: error.rawValue, buttonTitle: "Понятно")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
