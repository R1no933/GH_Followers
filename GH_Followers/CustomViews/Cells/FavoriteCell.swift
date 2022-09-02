//
//  FavoriteCell.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 30.08.2022.
//

import UIKit

class FavoriteCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "FavoriteCell"
    let avatarImageView = GHFAvataImageView(frame: .zero)
    let usernameLabel = GHFTitleLabel(textAligment: .left, fontSize: 24)
    
    //MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    //Set info for elements
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(fromURL: favorite.avatarUrl)
    }
    
    //Configure and layout cell
    private func configure() {
        addSubviews([avatarImageView, usernameLabel])
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.FavoriteCell.avatarLeading),
            avatarImageView.heightAnchor.constraint(equalToConstant: Metrics.FavoriteCell.avatarSize),
            avatarImageView.widthAnchor.constraint(equalToConstant: Metrics.FavoriteCell.avatarSize),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Metrics.FavoriteCell.usernameLeading),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.FavoriteCell.usernameTrailing),
            usernameLabel.heightAnchor.constraint(equalToConstant: Metrics.FavoriteCell.usernameHeight)
        ])
    }
}
