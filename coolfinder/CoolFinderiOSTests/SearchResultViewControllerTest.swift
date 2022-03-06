//
//  SearchResultViewControllerTest.swift
//  CoolFinderiOSTests
//
//  Created by Luis Zapata on 06-03-22.
//

import XCTest
import CoolFinderiOS
import Coolfinder

class SearchResultViewControllerTest: XCTestCase {
    
    func test_init_doesNotSearch() {
        let (_, repository) = makeSUT()
        XCTAssertEqual(repository.searchCounter, 0)
    }
    
    func test_viewInit_callsSearch() {
        let (sut, repository) = makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertEqual(repository.searchCounter, 1)
    }
    
    private func makeSUT() -> (SearchResultViewController, SearchRespositorySpy) {
        let repository = SearchRespositorySpy()
        return (SearchResultViewController(repository: repository), repository)
    }
    
    private class SearchRespositorySpy: SearchRespository {
        var searchCounter = 0
        func search(term: String, completion: @escaping ((SearchResult) -> Void)) {
            searchCounter += 1
        }
    }
}
