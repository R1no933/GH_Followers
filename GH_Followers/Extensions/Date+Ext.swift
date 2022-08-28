//
//  Date+Ext.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import Foundation

extension Date {
    
    //Mark: - Methods
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
