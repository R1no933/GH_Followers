//
//  GHFAvataImageView.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 27.08.2022.
//

import UIKit

class GHFAvataImageView: UIImageView {
    
    //MARK: - Properties
    let placeholderImage = Images.avatarPlaceholder
    let cache = NetworkManager.shared.cache
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    //Configure view
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
