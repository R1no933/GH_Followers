//
//  GHFItemInfoView.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import UIKit

class GHFItemInfoView: UIView {
    
    enum ItemInfoType {
        case repose, gists, followers, following
    }
    
    //MARK: - Properties
    let symbolImageView = UIImageView()
    let titleLabel = GHFTitleLabel(textAligment: .left, fontSize: 14)
    let countLabel = GHFTitleLabel(textAligment: .center, fontSize: 14)
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    //Set info type
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repose:
            symbolImageView.image = SFSymbols.repose
            titleLabel.text = "Репозитории"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Фрагменты"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Подписчики"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Подписки"
        }
        
        countLabel.text = String(count)
    }
    
    //Configure view
    private func configure() {
        addSubviews([symbolImageView, titleLabel, countLabel])
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: Metrics.ItemInfo.imageViewSize),
            symbolImageView.heightAnchor.constraint(equalToConstant: Metrics.ItemInfo.imageViewSize),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: Metrics.ItemInfo.titleLeading),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: Metrics.ItemInfo.labelHeight),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: Metrics.ItemInfo.countTop),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: Metrics.ItemInfo.labelHeight)
            
        ])
    }
}
