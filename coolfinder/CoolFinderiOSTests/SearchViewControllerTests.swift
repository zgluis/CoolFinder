//
//  SearchViewControllerTests.swift
//  CoolFinderiOSTests
//
//  Created by Luis Zapata on 05-03-22.
//

import XCTest
import CoolFinderiOS

class SearchViewControllerTests: XCTestCase {

    func test_init_doesNotHaveSideEffects() {
        let (sut, navController) = makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertEqual(navController.viewControllers.count, 1)
    }

    private func makeSUT() -> (SearchViewController, UINavigationController) {
        let sut = SearchViewController()
        let navController = UINavigationController(rootViewController: sut)
        return (sut, navController)
    }
}
