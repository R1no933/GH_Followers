//
//  FollowerCell.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 27.08.2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    //MARK: - Properies
    static let identifier = "FollowerCell"
    let avatarImageView = GHFAvataImageView(frame: .zero)
    let usernameLabel = GHFTitleLabel(textAligment: .center, fontSize: 16)
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure methods
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(fromURL: follower.avatarUrl)
    }
    
    private func configure() {
        addSubviews([avatarImageView, usernameLabel])
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.FollowerCell.padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.FollowerCell.padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.FollowerCell.padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Metrics.FollowerCell.padding),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.FollowerCell.padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.FollowerCell.padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: Metrics.FollowerCell.labelHeight)
        ])
    }
    
}
