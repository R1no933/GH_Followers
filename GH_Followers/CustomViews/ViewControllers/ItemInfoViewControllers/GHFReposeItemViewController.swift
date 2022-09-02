//
//  GHFReposeItemViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import UIKit

//MARK: - Protocol
protocol GHFReposeItemViewControllerDelegate: AnyObject {
    func didTapedShowProfile(for user: User)
}

class GHFReposeItemViewController: GHFItemInfoViewController {
    //MARK: - Properties
    weak var delegate: GHFReposeItemViewControllerDelegate!
    
    //MARK: - Inits
    init(user: User, delegate: GHFReposeItemViewControllerDelegate) {
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
        firstItemInfoView.set(itemInfoType: .repose, withCount: user.publicRepos)
        secondItemInfoView.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Показать профиль")
    }
    
    override func actionButtonTap() {
        delegate.didTapedShowProfile(for: user)
    }
}
