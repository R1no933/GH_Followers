//
//  GHFAllertViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import UIKit

class GHFAllertViewController: UIViewController {
    
    //MARK: - Properties
    let containerView = UIView()
    let titleLabel = GHFTitleLabel(textAligment: .center, fontSize: 20)
    let errorMessageLabel = GHFBodyLabel(textAligment: .center)
    let actionButton = GHFButton(backgroundColor: .systemPink, title: "Понятно")
    var alertTitle: String?
    var errorMessage: String?
    var buttonTitle: String?
    
    //MARK: - Inits
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.errorMessage = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70)
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureMessageLabel()
    }
    
    //MARK: - Objc funcs
    @objc func dismissAlertViewController() {
        dismiss(animated: true)
    }
    
    //MARK: - Layout container
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            containerView.widthAnchor.constraint(equalToConstant: 310)
        ])
    }
    
    //MARK: - Layout elements in container
    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Ooopss😱"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureMessageLabel() {
        containerView.addSubview(errorMessageLabel)
        errorMessageLabel.text = errorMessage ?? "Невозможно выполнить запрос! Алярм!!!🫣"
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            errorMessageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            errorMessageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            errorMessageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -6)
        ])
    }
    
    private func configureButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissAlertViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -28),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}