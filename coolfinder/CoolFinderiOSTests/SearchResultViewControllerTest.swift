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
        let (_, repository, _) = makeSUT()
        XCTAssertEqual(repository.messages.count, 0)
    }
    
    func test_viewInit_callsSearchPassingTerm() {
        let injectedTerm = "anyTerm"
        let (sut, repository, _) = makeSUT(term: injectedTerm)
        sut.loadViewIfNeeded()
        XCTAssertEqual(repository.terms, [injectedTerm])
    }
    
    func test_displaysError_on_SearchFailure() {
        let (sut, repository, _) = makeSUT()
        sut.loadViewIfNeeded()
        repository.complete(with: .failure(NSError()))
        XCTAssert(isErrorDisplayed(on: sut))
    }
    
    func test_doesnt_displaysError_on_SearchSuccess() {
        let (sut, repository, _) = makeSUT()
        sut.loadViewIfNeeded()
        repository.complete(with: .success([]))
        XCTAssertFalse(isErrorDisplayed(on: sut))
    }
    
    func test_handlesLoading_on_SearchRequestAndCompletion() {
        let (sut, repository, _) = makeSUT()
        sut.loadViewIfNeeded()
        XCTAssert(isLoadingDisplayed(on: sut))
        repository.complete(with: anySearchCompletionResult())
        XCTAssertFalse(isLoadingDisplayed(on: sut))
    }
    
    func test_displaysProductList_on_SearchSuccess() {
        let (sut, repository, _) = makeSUT()
        sut.loadViewIfNeeded()
        repository.complete(with: .success([]))
        XCTAssert(isProductListViewDisplayed(on: sut))
    }
    
    func test_navigatesToProductDetail_on_Item_Tap() {
        let (sut, _, navController) = makeSUT()
        sut.loadViewIfNeeded()
        sut.didTapProduct(product: anyProduct(withId: "anyId"))
        let didNavigateToProductDetail = navController.getPushedViewControllers().last is ProductDetailViewController
        XCTAssert(didNavigateToProductDetail)
    }
    
    private func makeSUT(term: String = "") -> (SearchResultViewController, SearchRespositorySpy, NavigationControllerSpy) {
        let repository = SearchRespositorySpy()
        let viewModel = SearchResultViewModel(searchTerm: term, repository: repository)
        let sut = SearchResultViewController(viewModel: viewModel)
        let navController = NavigationControllerSpy(rootViewController: sut)
        trackForMemoryLeaks(sut)
        return (sut, repository, navController)
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
    
    private func isProductListViewDisplayed(on sut: SearchResultViewController) -> Bool {
        return !sut.productListView.isHidden
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
    
    private func anyProduct(withId: String) -> Product {
        return Product(
            id: withId,
            title: "",
            price: .zero,
            thumbnail: URL(string: ""),
            installments: .init(quantity: .zero, amount: .zero)
        )
    }

}
