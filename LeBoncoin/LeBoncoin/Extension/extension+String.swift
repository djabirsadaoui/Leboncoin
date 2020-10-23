//
//  extension+Date.swift
//  LeBoncoin
//
//  Created by dsadaoui on 23/10/2020.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: self)
        return date
    }}
