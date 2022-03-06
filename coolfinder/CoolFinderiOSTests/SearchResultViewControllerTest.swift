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
        XCTAssertEqual(repository.messages.count, 0)
    }
    
    func test_viewInit_callsSearchPassingTerm() {
        let injectedTerm = "anyTerm"
        let (sut, repository) = makeSUT(term: injectedTerm)
        sut.loadViewIfNeeded()
        XCTAssertEqual(repository.messages, [injectedTerm])
    }
    
    private func makeSUT(term: String = "") -> (SearchResultViewController, SearchRespositorySpy) {
        let repository = SearchRespositorySpy()
        return (SearchResultViewController(searchTerm: term, repository: repository), repository)
    }
    
    private class SearchRespositorySpy: SearchRespository {
        var messages: [String] = []
        func search(term: String, completion: @escaping ((SearchResult) -> Void)) {
            messages.append(term)
        }
    }
}
