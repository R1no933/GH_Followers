//
//  UserInfoViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import UIKit

//MARK: - Protocols
protocol UserInfoViewControllerDelegate: AnyObject {
    func didRequestFollowers(with username: String)
}

class UserInfoViewController: UIViewController {
    
    //MARK: - Properties
    var username: String!
    let headerView = UIView()
    let firstItemsView = UIView()
    let secondItemsView = UIView()
    var viewsArray: [UIView] = []
    let dateLabel = GHFBodyLabel(textAligment: .center)
    weak var delegate: UserInfoViewControllerDelegate!
    let scrollView = UIScrollView()
    let contentView = UIView()
     
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureScrollView()
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
    
    //Configure scroll view
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
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
        self.add(childViewController: GHFReposeItemViewController(user: user, delegate: self), on: self.firstItemsView)
        self.add(childViewController: GHFFollowersItemViewController(user: user, delegate: self), on: self.secondItemsView)
        self.add(childViewController: GHFUserInfoHeaderViewController(user: user), on: self.headerView)
        self.dateLabel.text = "Since at: \(user.createdAt.convertDateToString())"
    }
    
    //Layouts user info screen
    private func layoutUI() {
        viewsArray = [headerView, firstItemsView, secondItemsView, dateLabel]
        for views in viewsArray {
            contentView.addSubview(views)
            views.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                views.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                views.trailingAnchor.constraint(equalTo: contentView .trailingAnchor, constant: -20)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220),
            
            firstItemsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            firstItemsView.heightAnchor.constraint(equalToConstant: 140),
            
            secondItemsView.topAnchor.constraint(equalTo: firstItemsView.bottomAnchor, constant: 20),
            secondItemsView.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: secondItemsView.bottomAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Objc methods
    @objc func dismissUserInfoViewController() {
        dismiss(animated: true)
    }
}

//MARK: - Extensions
extension UserInfoViewController: GHFReposeItemViewControllerDelegate {
    //Taped show profile button
    func didTapedShowProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: "Некорректная ссылка.", buttonTitle: "Понятно")
            return
        }
        
        presentSafariViewController(with: url)
    }
}

extension UserInfoViewController: GHFFollowersItemViewControllerDelegate {
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
