//
//  GHFUserInfoHeaderViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import UIKit

class GHFUserInfoHeaderViewController: UIViewController {
    
    //MARK: - Properties
    let avatarImageView = GHFAvataImageView(frame: .zero)
    let usernameLabel = GHFTitleLabel(textAligment: .left, fontSize: 34)
    let nameLabel = GHFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GHFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GHFBodyLabel(textAligment: .left)
    
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
        view.addSubviews([avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel])
        configure()
        layoutUI()
    }
    
    //MARK: - Methods
    //Configure UI elements
    private func configure() {
        avatarImageView.downloadImage(fromURL: user.avatarUrl)
        
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? "Имя не указано"
        locationLabel.text = user.location ?? "Локация не указана"
        bioLabel.text = user.bio ?? "..."
        bioLabel.numberOfLines = 3
        
        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }
    
    //Layouts
    private func layoutUI() {
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.UserInfoHeader.avatarTop),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: Metrics.UserInfoHeader.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: Metrics.UserInfoHeader.avatarSize),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Metrics.UserInfoHeader.usernameLeading),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: Metrics.UserInfoHeader.usernameHeight),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: Metrics.UserInfoHeader.nameYAcnhor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Metrics.UserInfoHeader.nameLeading),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: Metrics.UserInfoHeader.nameHeight),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Metrics.UserInfoHeader.locationImageLeading),
            locationImageView.widthAnchor.constraint(equalToConstant: Metrics.UserInfoHeader.locationImageSize),
            locationImageView.heightAnchor.constraint(equalToConstant: Metrics.UserInfoHeader.locationImageSize),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: Metrics.UserInfoHeader.locationLabelLeading),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: Metrics.UserInfoHeader.locationLabelHeight),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Metrics.UserInfoHeader.bioTop),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: Metrics.UserInfoHeader.bioHeight)
        ])
    }
}
