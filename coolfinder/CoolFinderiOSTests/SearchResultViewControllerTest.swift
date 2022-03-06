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
        XCTAssert(isErrorDisplayed(on: sut))
    }
    
    func test_doesnt_displaysError_on_SearchSuccess() {
        let (sut, repository) = makeSUT()
        sut.loadViewIfNeeded()
        repository.complete(with: .success([]))
        XCTAssertFalse(isErrorDisplayed(on: sut))
    }
    
    func test_displaysLoading_on_Search() {
        let (sut, repository) = makeSUT()
        sut.loadViewIfNeeded()
        XCTAssert(isLoadingDisplayed(on: sut))
        repository.complete(with: anySearchCompletionResult())
    }
    
    private func makeSUT(term: String = "") -> (SearchResultViewController, SearchRespositorySpy) {
        let repository = SearchRespositorySpy()
        let sut = SearchResultViewController(searchTerm: term, repository: repository)
        trackForMemoryLeaks(sut)
        return (sut, repository)
    }
    
    private func isErrorDisplayed(on sut: SearchResultViewController) -> Bool {
        return !sut.errorView.isHidden
    }
    
    private func anySearchCompletionResult() -> SearchResult {
        return  Bool.random() ? .success([]) : .failure(NSError())
    }
    
    private func isLoadingDisplayed(on sut: SearchResultViewController) -> Bool {
        return !sut.loadingView.isHidden
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
