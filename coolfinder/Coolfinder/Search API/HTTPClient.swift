//
//  HTTPClient.swift
//  Coolfinder
//
//  Created by Luis Zapata on 05-03-22.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
