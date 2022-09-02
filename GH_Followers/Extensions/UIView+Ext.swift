//
//  UIView+Ext.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 31.08.2022.
//

import UIKit

extension UIView {
    //MARK: - Methods
    //Add sunviews
    public func addSubviews(_ subviews: [UIView]) {
           subviews.forEach({ self.addSubview($0) })
    }
    
    //Pin to edges on superview
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
