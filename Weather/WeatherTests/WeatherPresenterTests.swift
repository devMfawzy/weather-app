//
//  WeatherPresenterTests.swift
//  WeatherTests
//
//  Created by Mohamed Fawzy on 22/09/2024.
//

import XCTest
@testable import Weather

final class WeatherPresenterTests: XCTestCase {
    var presenter: SearchPresenter!
    var view = SearchViewSpy()
    var interactor = MockSearchInteractor()

    override func setUpWithError() throws {
        try super.setUpWithError()
        presenter = SearchPresenter(
            router: SearchRouter(), interactor: interactor
        )
        interactor.output = presenter
        presenter.viewDidLoad(view: view)
    }

    override func tearDownWithError() throws {
        presenter = nil
        try super.tearDownWithError()
    }

    func testViewShouldShowFailureMessageWhenErrorIsExpected() throws {
        // Given
        interactor.expect(.error)
        let expectation = expectation(description: "presenter expectation")
        
        // When
        presenter.didChangeSearchText("text")

        // Then
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            XCTAssertFalse(view.isFailureMessageHidden)
            XCTAssertFalse(view.isLoadingData)
            XCTAssertTrue(view.isWeatherDataHidded)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testViewShouldShowWeatherDataWhenDataLoadIsExpected() throws {
        // Given
        interactor.expect(.data)
        let expectation = expectation(description: "presenter expectation")
        
        // When
        presenter.didChangeSearchText("text")

        // Then
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            XCTAssertTrue(view.isFailureMessageHidden)
            XCTAssertFalse(view.isLoadingData)
            XCTAssertFalse(view.isWeatherDataHidded)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testViewShouldShowLoadingIndicatorWhenResponseNotYetExist() throws {
        // Given
        interactor.expect(.loading)
        let expectation = expectation(description: "presenter expectation")
        
        // When
        presenter.didChangeSearchText("any")

        // Then
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            XCTAssertTrue(view.isFailureMessageHidden)
            XCTAssertTrue(view.isLoadingData)
            XCTAssertTrue(view.isWeatherDataHidded)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
