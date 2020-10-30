//
//  ApiFetcherMock.swift
//  LeBoncoinTests
//
//  Created by dsadaoui on 26/10/2020.
//
@testable import MVVMByBox
import XCTest

class MockAPIFetcher: APIFetchable {
    var isFetchAnnoucementsCalled = false
    var isFetchCategoriesCalled = false
    var isFetchAnnoucementsFailed = false
    var isFetchCategoriesFailed = false
    var announcements = [Announcement]()
    var categories = [MVVMByBox.Category]()
    func fetchAnnoucements(completion: @escaping (Result<[Announcement], APIError>) -> Void) {
        isFetchAnnoucementsCalled = true
        if isFetchAnnoucementsFailed {
            completion(.failure(.invalidResponse))
        } else {
            completion(.success(announcements))
        }
    }
    
    func fetchCategories(completion: @escaping (Result<[MVVMByBox.Category], APIError>) -> Void) {
        isFetchCategoriesCalled = true
        if isFetchCategoriesFailed {
            completion(.failure(.invalidResponse))
        } else {
            completion(.success(categories))
        }
    }
}

