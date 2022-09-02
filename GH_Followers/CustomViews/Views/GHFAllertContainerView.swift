//
//  GHFAllertContainerView.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 31.08.2022.
//

import UIKit

class GHFAllertContainerView: UIView {

    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
