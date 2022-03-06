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
    
    func test_navigates_on_SuggestionTap() {
        let (sut, navController) = makeSUT()
        sut.loadViewIfNeeded()
        sut.didTapSuggestionView()
        XCTAssertEqual(navController.getPushedViewControllers().count, 2)
    }

    private func makeSUT() -> (SearchViewController, NavigationControllerSpy) {
        let sut = SearchViewController()
        let navController = NavigationControllerSpy(rootViewController: sut)
        return (sut, navController)
    }
    
    class NavigationControllerSpy: UINavigationController {
        private var pushedViewControllers: [UIViewController] = []

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewControllers.append(viewController)
            super.pushViewController(viewController, animated: false)
        }
        
        func getPushedViewControllers() -> [UIViewController] {
            return pushedViewControllers
        }
    }
}
