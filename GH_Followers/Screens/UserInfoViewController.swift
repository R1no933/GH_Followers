//
//  UserInfoViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import UIKit

//MARK: - Protocols
protocol UserInfoViewControllerDelegate: class {
    func didTapedShowProfile(for user: User)
    func didTapedShowFollowers(for user: User)
}


class UserInfoViewController: UIViewController {
    
    //MARK: - Properties
    var username: String!
    let headerView = UIView()
    let firstItemsView = UIView()
    let secondItemsView = UIView()
    var viewsArray: [UIView] = []
    let dateLabel = GHFBodyLabel(textAligment: .center)
    weak var delegate: FollowerListViewControllerDelegate!
     
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
        getUserInfo(username: username)
    }
    
    //MARK: - Methods
    //Get user info
    private func getUserInfo(username: String) {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureViews(with: user) }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: error.rawValue, buttonTitle: "Понятно")
            }
        }
    }
    
    //Configure user info screen
    private func configure() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissUserInfoViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    //Add child view on header view
    private func add(childViewController: UIViewController, on containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
    
    //Configure child views
    private func configureViews(with user: User) {
        let repoInfoViewController = GHFReposeItemViewController(user: user)
        repoInfoViewController.delegate = self
        
        let followersItemViewCOntroller = GHFFollowersItemViewController(user: user)
        followersItemViewCOntroller.delegate = self
        
        self.add(childViewController: repoInfoViewController, on: self.firstItemsView)
        self.add(childViewController: followersItemViewCOntroller, on: self.secondItemsView)
        self.add(childViewController: GHFUserInfoHeaderViewController(user: user), on: self.headerView)
        self.dateLabel.text = "Since at: \(user.createdAt.convertToDisplayFormat())"
    }
    
    //Layouts user info screen
    private func layoutUI() {
        viewsArray = [headerView, firstItemsView, secondItemsView, dateLabel]
        for views in viewsArray {
            view.addSubview(views)
            views.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                views.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                views.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            firstItemsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            firstItemsView.heightAnchor.constraint(equalToConstant: 140),
            
            secondItemsView.topAnchor.constraint(equalTo: firstItemsView.bottomAnchor, constant: 20),
            secondItemsView.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: secondItemsView.bottomAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    //MARK: - Objc methods
    @objc func dismissUserInfoViewController() {
        dismiss(animated: true)
    }
}

//MARK: - Extensions
extension UserInfoViewController: UserInfoViewControllerDelegate {
    //Taped show profile button
    func didTapedShowProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: "Некорректная ссылка.", buttonTitle: "Понятно")
            return
        }
        
        presentSafariViewController(with: url)
    }
    
    //Tapped show followers button
    func didTapedShowFollowers(for user: User) {
        guard user.followers != 0 else {
            presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: "У пользователя нет подписчиков.", buttonTitle: "Понятно")
            return
        }
        delegate.didRequestFollowers(with: user.login)
        dismissUserInfoViewController()
    }
}
