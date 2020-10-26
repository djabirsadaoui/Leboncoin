//
//  HomeViewControllerTests.swift
//  LeBoncoinTests
//
//  Created by dsadaoui on 26/10/2020.
//
@testable import LeBoncoin
import XCTest

class HomeViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: HomeViewController!
    var mockHomeViewModel: MockHomeViewModel!
    var window: UIWindow!
    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = HomeViewController()
        window = UIWindow()
        mockHomeViewModel = MockHomeViewModel()
        
    }
    override func tearDown() {
        window = nil
        sut = nil
        super.tearDown()
        
    }
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
   
    func testIsLoadingStopped() throws {
        // Given
        let exp = expectation(description: "Activity indicator")
        sut.viewModel = mockHomeViewModel
        //When
        sut.bindViewModel()
        mockHomeViewModel.items.value = TestData.loadAnnoucements()
        //Then
        DispatchQueue.main.async() {
            XCTAssertFalse(self.sut.activityIndicator.isAnimating, "activity indicator should be stopped")
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    func testBindAnnouncement() throws {
        // Given
        let exp = expectation(description: "Reload Data")
        sut.viewModel = mockHomeViewModel
        //When
        loadView()
        sut.bindViewModel()
        mockHomeViewModel.items.value = TestData.loadAnnoucements()
        //Then
        DispatchQueue.main.async() {
            XCTAssertEqual(self.sut.annoucementsTableView.numberOfRows(inSection: 0), 3, "AnnouncementsTableView should be have 3 Cell")
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testBindAnnouncementEmpty() throws {
        // Given
        let exp = expectation(description: "Reload Data")
        sut.viewModel = mockHomeViewModel
        //When
        loadView()
        sut.bindViewModel()
        mockHomeViewModel.items.value = []
        //Then
        DispatchQueue.main.async() {
            XCTAssertEqual(self.sut.annoucementsTableView.numberOfRows(inSection: 0), 0, "TableView should be empty")
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testBindCategories() throws {
        // Given
        let exp = expectation(description: "Popover")
        sut.viewModel = mockHomeViewModel
        //When
        loadView()
        sut.bindViewModel()
        mockHomeViewModel.categories.value = TestData.loadCategoriess()
        //Then
        DispatchQueue.main.async() {
            XCTAssertEqual(self.sut.categoryViewController.tableView.numberOfRows(inSection: 0),11, "CategoriesTableView should be have 11 Cell")
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testDisplayPopover() throws {
        // Given
        let exp = expectation(description: "Popover")
        sut.viewModel = mockHomeViewModel
        //When
        loadView()
        sut.categoryButton.handleTap()
        //Then
        DispatchQueue.main.async() {
            XCTAssertTrue(self.sut.categoryViewController.isBeingPresented, "TableView should be empty")
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}




