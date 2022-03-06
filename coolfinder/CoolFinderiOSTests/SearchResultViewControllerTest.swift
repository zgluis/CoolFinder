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
        XCTAssertEqual(repository.terms, [injectedTerm])
    }
    
    func test_displaysError_on_SearchFailure() {
        let (sut, repository) = makeSUT()
        sut.loadViewIfNeeded()
        repository.complete(with: .failure(NSError()))
        XCTAssertFalse(sut.errorView.isHidden)
    }
    
    private func makeSUT(term: String = "") -> (SearchResultViewController, SearchRespositorySpy) {
        let repository = SearchRespositorySpy()
        let sut = SearchResultViewController(searchTerm: term, repository: repository)
        trackForMemoryLeaks(sut)
        return (sut, repository)
    }
    
    private class SearchRespositorySpy: SearchRespository {
        var messages: [(term: String, completion: ((SearchResult) -> Void))] = []
        var terms: [String] {
            return messages.map ({ $0.term })
        }
        
        func search(term: String, completion: @escaping ((SearchResult) -> Void)) {
            messages.append((term, completion))
        }
        
        func complete(with result: SearchResult, at index: Int = 0) {
            messages[index].completion(result)
        }
    }
}