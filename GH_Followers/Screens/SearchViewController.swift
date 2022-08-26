//
//  ViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    let logoImageView = UIImageView()
    let userNameTextField = GHFTextField()
    let getFollowersButton = GHFButton(backgroundColor: .systemGreen, title: "Показать подписчиков")
    var isUserNameEnterted: Bool { return !userNameTextField.text!.isEmpty }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureButton()
        dismissKeyboardForTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Dismiss keyboard for tap anywhere
    func dismissKeyboardForTap() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Objc funcs
    @objc func pushFolloweListViewControlloer() {
        guard isUserNameEnterted else {
            presentAlertOnMainThread(
                title: "Введите имя пользователя!",
                message: "Введите имя пользователя! Мы же должны знать, кого искать 🤓.",
                buttonTitle: "Понятно")
            return
        }
        let followerListViewController = FollowerListViewController()
        followerListViewController.username = userNameTextField.text
        followerListViewController.title = userNameTextField.text
        navigationController?.pushViewController(followerListViewController, animated: true)
    }
    
    //MARK: - Layouts
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 220),
            logoImageView.widthAnchor.constraint(equalToConstant: 220)
        ])
        
    }
    
    private func configureTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureButton() {
        view.addSubview(getFollowersButton)
        getFollowersButton.addTarget(self, action: #selector(pushFolloweListViewControlloer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - Extensions
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFolloweListViewControlloer()
        return true
    }
}

