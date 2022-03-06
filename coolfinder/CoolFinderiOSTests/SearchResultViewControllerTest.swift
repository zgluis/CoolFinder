//
//  SearchResultViewControllerTest.swift
//  CoolFinderiOSTests
//
//  Created by Luis Zapata on 06-03-22.
//

import XCTest
import CoolFinderiOS

class SearchResultViewControllerTest: XCTestCase {
    
    func test_init_doesNotSearch() {
        let (_, repository) = makeSUT()
        XCTAssertEqual(repository.searchCounter, 0)
    }
    
    private func makeSUT() -> (SearchResultViewController, RepositorySpy) {
        let repository = RepositorySpy()
        return (SearchResultViewController(repository: repository), repository)
    }
    
    private class RepositorySpy: Repository {
        var searchCounter = 0
        
    }
}
