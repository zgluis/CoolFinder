//
//  RemoteSearchRepositoryTests.swift
//  CoolfinderTests
//
//  Created by Luis Zapata on 03-03-22.
//

import XCTest
import Coolfinder
    
class RemoteSearchRepositoryTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_requestDataFromUrl_on_Search() {
        let (sut, client) = makeSUT(url: anyURL())
        sut.search()
        XCTAssertEqual(client.requestedURLs, [anyURL()])
    }
    
    func test_requestDataFromUrlTwice_on_SearchTwice() {
        let (sut, client) = makeSUT(url: anyURL())
        sut.search()
        sut.search()
        XCTAssertEqual(client.requestedURLs, [anyURL(), anyURL()])
    }
    
    func test_search_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var capturedErrors: [RemoteSearchRespository.Error] = []
        sut.search { error in
            capturedErrors.append(error)
        }
        
        let genericError = NSError(domain: "GenericError", code: 0)
        client.completions[0](genericError)
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    private func makeSUT(url: URL = URL(string: "https://dummy-url.com")!) -> (RemoteSearchRespository, HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        return (RemoteSearchRespository(url: url, httpClient: httpClient), httpClient)
    }
    
    private func anyURL() -> URL {
        return URL(string: "https://dummy-url.com")!
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs = [URL]()
        var completions = [(Error) -> Void]()
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            completions.append(completion)
            requestedURLs.append(url)
        }
    }
}
