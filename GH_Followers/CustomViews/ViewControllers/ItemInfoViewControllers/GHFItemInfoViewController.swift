//
//  GHFItemInfoViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import UIKit

//MARK: - Protocols
protocol ItemInfoViewControllerDelegate: AnyObject {
    func didTapedShowProfile(for user: User)
    func didTapedShowFollowers(for user: User)
}

class GHFItemInfoViewController: UIViewController {
    
    //MARK: - Properties
    let stackView = UIStackView()
    let firstItemInfoView = GHFItemInfoView()
    let secondItemInfoView = GHFItemInfoView()
    let actionButton = GHFButton()
    var user: User!
    
    //MARK: - Inits
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        layout()
        configureStackView()
        configureActionButton()
    }
    
    //MARK: - Methods
    //Configure backgound for view
    private func configureBackground() {
        view.layer.cornerRadius = 15
        view.backgroundColor = .secondarySystemBackground
    }
    
    //Configure stack view
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(firstItemInfoView)
        stackView.addArrangedSubview(secondItemInfoView)
    }
    
    //Configure button
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTap), for: .touchUpInside)
    }
    
    //Layout UI elements
    private func layout() {
        view.addSubviews([stackView, actionButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.ItemInfoVC.padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.ItemInfoVC.padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.ItemInfoVC.padding),
            stackView.heightAnchor.constraint(equalToConstant: Metrics.ItemInfoVC.height),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Metrics.ItemInfoVC.padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.ItemInfoVC.padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.ItemInfoVC.padding),
            actionButton.heightAnchor.constraint(equalToConstant: Metrics.ItemInfoVC.height)
        ])
    }
    
    //MARK: - Objc methods
    @objc func actionButtonTap() {}
}
