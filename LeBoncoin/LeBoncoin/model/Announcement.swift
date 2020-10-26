//
//  Announcement.swift
//  LeBoncoin
//
//  Created by dsadaoui on 21/10/2020.
//

import Foundation

// MARK: - Announcement
struct Announcement: Codable {
    let id, categoryID: Int
    var categoryName: String?
    let title, welcomeDescription: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case welcomeDescription = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
        case categoryName
    }
}

// MARK: - ImagesURL
struct ImagesURL: Codable {
    let small: String?
    let thumb: String?
}
