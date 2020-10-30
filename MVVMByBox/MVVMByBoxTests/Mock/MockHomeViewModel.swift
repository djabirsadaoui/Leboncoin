//
//  HomeViewModelMock.swift
//  LeBoncoinTests
//
//  Created by dsadaoui on 26/10/2020.
//
@testable import MVVMByBox
import XCTest

class MockHomeViewModel: HomeViewModelProtocol {
    var isLoading: Box<Bool> = Box(false)

    var isFailed = false
    var testData = [Announcement]()
    var items: Box<[Announcement]> = Box([])
    
    var categories: Box<[MVVMByBox.Category]> = Box([])
    
    var errorMessage: Box<String?> = Box(nil)
    
    var filter: MVVMByBox.Category?
}
