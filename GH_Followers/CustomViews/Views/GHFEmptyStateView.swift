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
        addSubviews([messageLabel, emptyStateImageView])
        configureMessageLabel()
        configureImageView()
    }
    
    //Configure message label
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -Metrics.EmptyState.messageLabelYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.EmptyState.messageLabelPadding),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.EmptyState.messageLabelPadding),
            messageLabel.heightAnchor.constraint(equalToConstant: Metrics.EmptyState.messageLabelHeight)
        ])
    }
    
    //Configure empty state image view
    private func configureImageView() {
        emptyStateImageView.image = Images.emptyStateLogo
        emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyStateImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: Metrics.EmptyState.multiplier),
            emptyStateImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: Metrics.EmptyState.multiplier),
            emptyStateImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.EmptyState.imageViewTrailing),
            emptyStateImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Metrics.EmptyState.imageViewBottom)
        ])
    }
}
