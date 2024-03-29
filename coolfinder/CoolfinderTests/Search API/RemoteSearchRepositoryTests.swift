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
    
    func test_requestDataFromUrlWithTerm_on_Search() {
        let (sut, client) = makeSUT(url: anyURL())
        let term = anyTerm()
        sut.search(term: term) { _ in }
        XCTAssertEqual(client.requestedURLs, [anyURLWithTerm(term)])
    }
    
    func test_requestDataFromUrlTwice_on_SearchTwice() {
        let (sut, client) = makeSUT(url: anyURL())
        let term = anyTerm()
        sut.search(term: term) { _ in }
        sut.search(term: term) { _ in }
        XCTAssertEqual(client.requestedURLs, [anyURLWithTerm(term), anyURLWithTerm(term)])
    }
    
    func test_search_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        expect(sut, toCompleteWith: failure(.connectivity), when: {
            let genericError = NSError(domain: "GenericError", code: 0)
            client.complete(with: genericError)
        })
    }
    
    func test_search_deliversErrorOnNonHttp2XXResponse() {
        let (sut, client) = makeSUT()
        expect(sut, toCompleteWith: failure(.invalidData), when: {
            client.complete(withStatusCode: 400)
        })
    }
    
    func test_search_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        expect(sut, toCompleteWith: failure(.invalidData), when: {
            client.complete(withStatusCode: 200, data: anyInvalidJson())
        })
    }
    
    func test_search_deliversErrorOnNonHTTP2XXResponseWithJSONItems() {
        let (sut, client) = makeSUT()
        let mockedDataFile = mockedSearchResultTwoEmptyUniqueItems
        expect(sut, toCompleteWith: failure(.invalidData), when: {
            client.complete(
                withStatusCode: 400,
                data: mockedJsonData(for: self.classForCoder, fileName: mockedDataFile())
            )
        })
    }
    
    func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .success([]), when: {
            client.complete(withStatusCode: 200, data: anyEmptyValidJson())
        })
    }
    
    func test_search_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()
        let product1 = emptyProduct(withId: "1")
        let product2 = emptyProduct(withId: "2")
        let mockedDataFile = mockedSearchResultTwoEmptyUniqueItems
        expect(sut, toCompleteWith: .success([product1, product2]), when: {
            client.complete(
                withStatusCode: 200,
                data: mockedJsonData(for: self.classForCoder, fileName: mockedDataFile())
            )
        })
    }
    
    private func makeSUT(url: URL = URL(string: "https://dummy-url.com")!) -> (RemoteSearchRespository, HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        let repository = RemoteSearchRespository(url: url, httpClient: httpClient)
        trackForMemoryLeaks(repository)
        trackForMemoryLeaks(httpClient)
        return (repository, httpClient)
    }
    
    private func failure(_ error: RemoteSearchRespository.Error) -> RemoteSearchRespository.Result {
        return .failure(error)
    }
    
    private func expect(
        _ sut: RemoteSearchRespository,
        toCompleteWith expectedResult: RemoteSearchRespository.Result,
        when action: () -> Void,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.search(term: anyTerm()) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
                
            case let (.failure(receivedError as RemoteSearchRespository.Error), .failure(expectedError as RemoteSearchRespository.Error)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func anyURL() -> URL {
        return URL(string: "https://dummy-url.com")!
    }
    
    private func anyURLWithTerm(_ term: String) -> URL {
        var urlComponents = URLComponents(string: anyURL().absoluteString)
        urlComponents?.queryItems = [URLQueryItem(name: "q", value: term)]
        return urlComponents!.url!
    }
    
    private func anyTerm() -> String {
        return "anyTerm"
    }
    
    private func anyInvalidJson() -> Data {
        return Data("invalid json".utf8)
    }
    
    private func anyEmptyValidJson() -> Data {
        return Data("{\"results\": []}".utf8)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()

        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, params: [URLQueryItem] = [], completion: @escaping (HTTPClient.Result) -> Void) {
            var composedURL = url
            if params.count > 0, let parameterizedURL = add(params: params, to: url) {
                composedURL = parameterizedURL
            }
            messages.append((composedURL, completion))
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
            messages[index].completion(.success((data, response!)))
        }
        
        private func add(params: [URLQueryItem], to url: URL) -> URL? {
            var urlComponents = URLComponents(string: url.absoluteString)
            urlComponents?.queryItems = params
            return urlComponents?.url
        }
    }
    private func mockedSearchResultTwoEmptyUniqueItems() -> String {
        "MockSearchResultTwoEmptyUniqueItems"
    }
    
    private func mockedJsonData(
        for bundleClass: AnyClass,
        fileName: String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Data {
        if let path = Bundle(for: bundleClass.self).path(forResource: fileName, ofType: "json") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            XCTAssertNotNil(data, "Expected json string but got nil")
            return data ?? Data()
        } else {
            XCTFail("Unable to find json \(fileName) in bundle class \(bundleClass)")
            return Data()
        }
    }
    
    private func emptyProduct(withId: String) -> Product {
        return Product(
            id: withId,
            title: "",
            price: .zero,
            thumbnail: URL(string: ""),
            installments: .init(quantity: .zero, amount: .zero)
        )
    }
}
