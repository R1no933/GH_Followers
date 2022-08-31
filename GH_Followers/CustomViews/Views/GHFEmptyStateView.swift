//
//  GHFEmptyStateView.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 27.08.2022.
//

import UIKit

class GHFEmptyStateView: UIView {
    
    //MARK: - Properties
    let messageLabel = GHFTitleLabel(textAligment: .center, fontSize: 28)
    let emptyStateImageView = UIImageView()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        self.messageLabel.text = message
    }
    
    //MARK: - Methods
    //Configure view
    private func configure() {
        addSubview(messageLabel)
        addSubview(emptyStateImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        emptyStateImageView.image = UIImage(named: "empty-state-logo")
        emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -170),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 45),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -45),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            emptyStateImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyStateImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyStateImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 255),
            emptyStateImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
    }
}
