//
//  AnnoucementStore.swift
//  LeBoncoinTests
//
//  Created by dsadaoui on 26/10/2020.
//
@testable import LeBoncoin
import Foundation


class TestData {
    
    static func loadAnnoucements() -> [Announcement]{
        guard let pathString = Bundle(for: TestData.self).path(forResource: "AnnouncementsTestData", ofType: "json") else {
            print("AnnouncementsTestData.json not found")
            return []
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            print("Unable to convert AnnouncementsTestData.json to String")
            return []
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Unable to convert AnnouncementsTestData.json to Data")
            return []
        }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode([Announcement].self, from: jsonData)
            return result
        } catch {
            print("Unable to parsse Announcement Data")
            return []
        }
    }
    
    static func loadCategoriess() -> [LeBoncoin.Category]{
        guard let pathString = Bundle(for: TestData.self).path(forResource: "CategoriesTestData", ofType: "json") else {
            print("CategoriesTestData.json not found")
            return []
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            print("Unable to convert CategoriesTestData.json to String")
            return []
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Unable to convert CategoriesTestData.json to Data")
            return []
        }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode([LeBoncoin.Category].self, from: jsonData)
            return result
        } catch {
            print("Unable to parsse Category Data")
            return []
        }
    }
}
