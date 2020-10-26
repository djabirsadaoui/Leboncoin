//
//  APIError.swift
//  LeBoncoin
//
//  Created by dsadaoui on 21/10/2020.
//

import Foundation

enum APIError: Error {
    case parsing(description: String)
    case network(description: String)
    case invalidURL
    case invalidResponse
}
