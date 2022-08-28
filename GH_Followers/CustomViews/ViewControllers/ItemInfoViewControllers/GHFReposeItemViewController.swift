//
//  GHFReposeItemViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import UIKit

class GHFReposeItemViewController: GHFItemInfoViewController {
        
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    //MARK: - Methods
    //Configure item
    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .repose, withCount: user.publicRepos)
        secondItemInfoView.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Показать профиль")
    }
    
    override func actionButtonTap() {
        delegate.didTapedShowProfile(for: user)
    }
}
