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
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews([
            logoImageView,
            userNameTextField,
            getFollowersButton
        ])
        configureLogoImageView()
        configureTextField()
        configureButton()
        dismissKeyboardForTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Methods
    //Dismiss keyboard for tap anywhere
    func dismissKeyboardForTap() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    //Layouts
    private func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraint: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 90
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraint)
        logoImageViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 220),
            logoImageView.widthAnchor.constraint(equalToConstant: 220)
        ])
        
    }
    
    private func configureTextField() {
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureButton() {
        getFollowersButton.addTarget(self, action: #selector(pushFolloweListViewControlloer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
        
        userNameTextField.resignFirstResponder()
        let followerListViewController = FollowerListViewController(username: userNameTextField.text!)
        navigationController?.pushViewController(followerListViewController, animated: true)
    }
}

//MARK: - Extensions
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFolloweListViewControlloer()
        return true
    }
}

