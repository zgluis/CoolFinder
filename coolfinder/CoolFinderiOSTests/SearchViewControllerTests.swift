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
        XCTAssertEqual(navController.getPushedViewControllers().count, 1)
    }
    
    func test_init_loadSearchViewOnInit() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        XCTAssert(sut.view is SearchView)
    }
    
    func test_navigates_to_SearchResult_on_SuggestionTap() {
        let (sut, navController) = makeSUT()
        sut.loadViewIfNeeded()
        sut.didTapSuggestion(term: anyTerm())
        let didNavigateToSearchResultVC = navController.getPushedViewControllers().last is SearchResultViewController
        XCTAssert(didNavigateToSearchResultVC)
    }
    
    func test_navigates_to_SearchResult_on_ReturnKeyTap() {
        let (sut, navController) = makeSUT()
        sut.loadViewIfNeeded()
        sut.didTapReturnKey(term: anyTerm())
        let didNavigateToSearchResultVC = navController.getPushedViewControllers().last is SearchResultViewController
        XCTAssert(didNavigateToSearchResultVC)
    }

    private func makeSUT() -> (SearchViewController, NavigationControllerSpy) {
        let sut = SearchViewController()
        let navController = NavigationControllerSpy(rootViewController: sut)
        return (sut, navController)
    }
    
    private func anyTerm() -> String {
        return "any"
    }
}
