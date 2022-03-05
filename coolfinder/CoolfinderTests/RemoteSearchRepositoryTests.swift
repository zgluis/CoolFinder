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
        sut.search { _ in }
        XCTAssertEqual(client.requestedURLs, [anyURL()])
    }
    
    func test_requestDataFromUrlTwice_on_SearchTwice() {
        let (sut, client) = makeSUT(url: anyURL())
        sut.search { _ in }
        sut.search { _ in }
        XCTAssertEqual(client.requestedURLs, [anyURL(), anyURL()])
    }
    
    func test_search_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var capturedErrors: [RemoteSearchRespository.Error] = []
        sut.search { error in
            capturedErrors.append(error)
        }
        
        let genericError = NSError(domain: "GenericError", code: 0)
        client.complete(with: genericError)
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    func test_search_deliversErrorOnNonHttp2XXResponse() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [RemoteSearchRespository.Error]()
        sut.search { capturedErrors.append($0) }
        client.complete(withStatusCode: 400)
        
        XCTAssertEqual(capturedErrors, [.invalidData])
    }
    
    func test_search_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [RemoteSearchRespository.Error]()
        sut.search { capturedErrors.append($0) }
        
        client.complete(withStatusCode: 200, data: anyInvalidJson())
        
        XCTAssertEqual(capturedErrors, [.invalidData])
    }
    
    private func makeSUT(url: URL = URL(string: "https://dummy-url.com")!) -> (RemoteSearchRespository, HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        return (RemoteSearchRespository(url: url, httpClient: httpClient), httpClient)
    }
    
    private func anyURL() -> URL {
        return URL(string: "https://dummy-url.com")!
    }
    
    private func anyInvalidJson() -> Data {
        return Data("invalid json".utf8)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()

        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )
            messages[index].completion(.success(data, response!))
        }
    }
}
