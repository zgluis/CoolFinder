//
//  HTTPClient.swift
//  Coolfinder
//
//  Created by Luis Zapata on 05-03-22.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    func get(from url: URL, params: [URLQueryItem], completion: @escaping (HTTPClient.Result) -> Void)
}
