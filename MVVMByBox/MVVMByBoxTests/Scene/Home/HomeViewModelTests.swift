//
//  HomeViewModelTests.swift
//  LeBoncoinTests
//
//  Created by dsadaoui on 26/10/2020.
//
@testable import MVVMByBox
import XCTest

class HomeViewModelTests: XCTestCase {
    // MARK: Subject under test
    var mockApiFetcher: MockAPIFetcher!
    var sut: HomeViewModel!
    
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        mockApiFetcher = nil
        super.tearDown()
    }
    
    // MARK: Tests
    func testGetAnnouncmentsCalled() throws {
        // Given
        mockApiFetcher = MockAPIFetcher()
        // When
        sut = HomeViewModel(apifetcher: mockApiFetcher)
        // Then
        XCTAssertTrue(mockApiFetcher.isFetchAnnoucementsCalled, "fetchAnnoucements method should be called")
    }
    
    func testGetAnnoucementsEmpty() throws {
        // Given
        mockApiFetcher = MockAPIFetcher()
        // When
        sut = HomeViewModel(apifetcher: mockApiFetcher)
        // Then
        XCTAssertTrue(sut.announcements.isEmpty, "annoucements list should be empty")
    }
    
    func testGetAnnoucementsSuccessful() throws {
        // Given
        mockApiFetcher = MockAPIFetcher()
        // When
        mockApiFetcher.announcements = TestData.loadAnnoucements()
        sut = HomeViewModel(apifetcher: mockApiFetcher)
        // Then
        XCTAssertTrue(sut.announcements.count == 3, "annoucement list should be 3")
    }
    
    func testGetAnnoucementsFailed() throws {
        // Given
        mockApiFetcher = MockAPIFetcher()
        mockApiFetcher.isFetchAnnoucementsFailed = true
        // When
        sut = HomeViewModel(apifetcher: mockApiFetcher)
        // Then
        XCTAssertNotNil(sut.errorMessage.value, "errorMessage should not be nil")
    }
    
    func testGetCategoriesCalled() throws {
        // Given
        mockApiFetcher = MockAPIFetcher()
        // When
        sut = HomeViewModel(apifetcher: mockApiFetcher)
        // Then
        XCTAssertTrue(mockApiFetcher.isFetchCategoriesCalled, "fetchCategories method should be called")
    }
    
    func testGetCategoriesNotCalled() throws {
        // Given
        mockApiFetcher = MockAPIFetcher()
        mockApiFetcher.isFetchAnnoucementsFailed = true
        // When
        sut = HomeViewModel(apifetcher: mockApiFetcher)
        // Then
        XCTAssertFalse(mockApiFetcher.isFetchCategoriesCalled, "fetchCategories method should not be called")
    }
    
    func testGetCategoriesSuccessful() throws {
        // Given
        mockApiFetcher = MockAPIFetcher()
        // When
        mockApiFetcher.announcements = TestData.loadAnnoucements()
        mockApiFetcher.categories = TestData.loadCategoriess()
        sut = HomeViewModel(apifetcher: mockApiFetcher)
        // Then
        XCTAssertTrue(sut.categories.value.count == 12, "annoucement list should be 12")
    }
    
    func testFilter() throws {
        // Given
        let exp = expectation(description: "Filter test")
        mockApiFetcher = MockAPIFetcher()
        mockApiFetcher.announcements = TestData.loadAnnoucements()
        mockApiFetcher.categories = TestData.loadCategoriess()
        // When
        sut = HomeViewModel(apifetcher: mockApiFetcher)
        sut.filter = Category(id: 4, name: "")
        // Then
        DispatchQueue.main.async() {
            XCTAssertTrue(self.sut.items.value.count == 2, "items should be 2")
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
