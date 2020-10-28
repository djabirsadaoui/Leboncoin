//
//  extension+Date.swift
//  LeBoncoin
//
//  Created by dsadaoui on 23/10/2020.
//

import Foundation

extension String {
    
    /// This function converts a String to Date
    /// - Returns: it returns the date which corresponds to the String
    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: self)
        return date
    }
    
    /// This function returns a date in the format passed in parameter
    /// - Parameter format: date format
    /// - Returns: it returns date in String format
    func dateFromString(_ format: String = "d MMM y, HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        guard let date = self.stringToDate() else {
            return ""
        }
        return dateFormatter.string(from: date)
    }
}
