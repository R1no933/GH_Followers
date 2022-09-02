//
//  UIView+Ext.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 31.08.2022.
//

import UIKit

extension UIView {
    //MARK: - Methods
    public func addSubviews(_ subviews: [UIView]) {
           subviews.forEach({ self.addSubview($0) })
    }
}
