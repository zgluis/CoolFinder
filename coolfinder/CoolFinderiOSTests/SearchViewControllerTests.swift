//
//  SearchViewControllerTests.swift
//  CoolFinderiOSTests
//
//  Created by Luis Zapata on 05-03-22.
//

import XCTest
import CoolFinderiOS

class SearchViewControllerTests: XCTestCase {

    func test_init_doesNotSearch() {
        let (sut, repository) = makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertEqual(repository.searchCounter, 0)
    }

    private func makeSUT() -> (SearchViewController, RepositorySpy) {
        let repository = RepositorySpy()
        return (SearchViewController(repository: repository), repository)
    }
    
    private class RepositorySpy: Repository {
        var searchCounter = 0
        
    }
}
