//
//  RemoteSearchRepositoryTests.swift
//  CoolfinderTests
//
//  Created by Luis Zapata on 03-03-22.
//

import XCTest

protocol HTTPClient {
    func get(from url: URL)
}

private class RemoteSearchRespository {
    private let client: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.client = httpClient
    }
}

class RemoteSearchRepositoryTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertNil(client.requestedURL)
    }
    
    private func makeSUT() -> (RemoteSearchRespository, HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        return (RemoteSearchRespository(httpClient: httpClient), httpClient)
    }
    
    private class HTTPClientSpy: HTTPClient {
        func get(from url: URL) {
            requestedURL = url
        }
        
        var requestedURL: URL?
    }
}
