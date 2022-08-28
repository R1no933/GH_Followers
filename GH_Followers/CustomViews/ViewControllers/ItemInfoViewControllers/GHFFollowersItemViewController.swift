//
//  GHFFollowersItemViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import UIKit

class GHFFollowersItemViewController: GHFItemInfoViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    //MARK: - Methods
    //Configure item
    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .followers, withCount: user.followers)
        secondItemInfoView.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Показать подписчиков")
    }
    
    override func actionButtonTap() {
        delegate.didTapedShowFollowers(for: user)
    }
}
