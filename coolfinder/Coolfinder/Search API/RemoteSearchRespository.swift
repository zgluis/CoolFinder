//
//  RemoteSearchRespository.swift
//  Coolfinder
//
//  Created by Luis Zapata on 04-03-22.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}

public class RemoteSearchRespository: SearchRespository {
    private let client: HTTPClient
    private let url: URL
    
    public init(url: URL, httpClient: HTTPClient) {
        self.url = url
        self.client = httpClient
    }
    
    public func search() {
        client.get(from: url)
    }
}
