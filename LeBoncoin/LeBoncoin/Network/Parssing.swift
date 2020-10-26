//
//  Parssing.swift
//  LeBoncoin
//
//  Created by dsadaoui on 21/10/2020.
//

import Foundation


func decode<T: Decodable>(_ data: Data) -> Result<T, APIError> {
  let decoder = JSONDecoder()
    do {
        let result = try decoder.decode(T.self, from: data)
        return Result.success(result)
    } catch {
        return Result.failure(.parsing(description: error.localizedDescription))
    }
}
