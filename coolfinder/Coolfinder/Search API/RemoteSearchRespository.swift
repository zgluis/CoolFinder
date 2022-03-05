//
//  RemoteSearchRespository.swift
//  Coolfinder
//
//  Created by Luis Zapata on 04-03-22.
//

import Foundation

public class RemoteSearchRespository: SearchRespository {
    private let client: HTTPClient
    private let url: URL
    private let searchQueryItemKey = "q"
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = SearchResult
    
    public init(url: URL, httpClient: HTTPClient) {
        self.url = url
        self.client = httpClient
    }
    
    public func search(term: String, completion: @escaping (Result) -> Void) {
        let queryItem = URLQueryItem(name: searchQueryItemKey, value: term)
        client.get(from: url, params: [queryItem]) { result in
            switch result {
            case let .success(data, httpResponse):
                completion(SearchProductsMapper.map(data, from: httpResponse))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}
