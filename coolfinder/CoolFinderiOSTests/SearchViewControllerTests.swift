//
//  SearchViewControllerTests.swift
//  CoolFinderiOSTests
//
//  Created by Luis Zapata on 05-03-22.
//

import XCTest

protocol Repository {
    
}

final class SearchViewController: UIViewController {
    private var repository: Repository?
    
    convenience init(repository: Repository) {
        self.init()
        self.repository = repository
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

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
