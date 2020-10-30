//
//  AnnoucementAPI.swift
//  LeBoncoin
//
//  Created by dsadaoui on 21/10/2020.
//

import Foundation

enum API {
    case annoucementURL
    case gatigoryURL
    
    func request() -> URL? {
        switch self {
        case .annoucementURL:
            return URL(string:"https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")
        case .gatigoryURL:
            return URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")
        }
    }
}
