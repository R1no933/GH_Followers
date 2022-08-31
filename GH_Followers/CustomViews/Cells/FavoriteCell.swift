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
    let username = GHFTitleLabel(textAligment: .left, fontSize: 24)
    
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
        username.text = favorite.login
        
        NetworkManager.shared.downloadAvatarImage(from: favorite.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    //Configure and layout cell
    private func configure() {
        addSubview(avatarImageView)
        addSubview(username)
        
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            username.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            username.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            username.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            username.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
