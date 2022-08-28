//
//  String+Ext.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 28.08.2022.
//

import Foundation

extension String {
    
    //Mark: - Methods
    //Convert to date
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    //Convert date to display format
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "Нет данных"}
        return date.convertDateToString()
    }
}
