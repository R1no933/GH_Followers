//
//  GHFFollowersItemViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import UIKit

//MARK: - Protocol
protocol GHFFollowersItemViewControllerDelegate: AnyObject {
    func didTapedShowFollowers(for user: User)
}

class GHFFollowersItemViewController: GHFItemInfoViewController {
    //MARK: - Properties
    weak var delegate: GHFFollowersItemViewControllerDelegate!
    
    //MARK: - Inits
    init(user: User, delegate: GHFFollowersItemViewControllerDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
