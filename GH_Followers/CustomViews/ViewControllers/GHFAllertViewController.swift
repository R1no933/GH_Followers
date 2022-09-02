//
//  GHFAllertViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import UIKit

class GHFAllertViewController: UIViewController {
    
    //MARK: - Properties
    let containerView = GHFAllertContainerView()
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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews([containerView, titleLabel, errorMessageLabel, actionButton])
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
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: Metrics.AlertVC.containerViewHeight),
            containerView.widthAnchor.constraint(equalToConstant: Metrics.AlertVC.containerViewWidth)
        ])
    }
    
    //MARK: - Layout elements in container
    private func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Ooopss😱"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Metrics.AlertVC.titleLabelPadding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.AlertVC.titleLabelPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.AlertVC.titleLabelPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: Metrics.AlertVC.titleLabelHeight)
        ])
    }
    
    private func configureMessageLabel() {
        errorMessageLabel.text = errorMessage ?? "Невозможно выполнить запрос! Алярм!!!🫣"
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.AlertVC.messageLabelTopAndBot),
            errorMessageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.AlertVC.messageLabelLeadingAndTrailing),
            errorMessageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.AlertVC.messageLabelLeadingAndTrailing),
            errorMessageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -Metrics.AlertVC.messageLabelTopAndBot)
        ])
    }
    
    private func configureButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissAlertViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Metrics.AlertVC.buttonPadding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.AlertVC.buttonPadding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.AlertVC.buttonPadding),
            actionButton.heightAnchor.constraint(equalToConstant: Metrics.AlertVC.buttonHeight)
        ])
    }
}
