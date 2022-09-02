//
//  UITableView+Ext.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 02.09.2022.
//

import UIKit

extension UITableView {
    //MARK: - Methods
    //Reload data on main thread
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    //Remove excess cells
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
