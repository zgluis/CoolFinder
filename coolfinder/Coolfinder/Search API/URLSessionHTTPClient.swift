//
//  URLSessionHTTPClient.swift
//  Coolfinder
//
//  Created by Luis Zapata on 05-03-22.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    public func get(from url: URL, params: [URLQueryItem] = [], completion: @escaping (HTTPClient.Result) -> Void) {
        var composedURL = url
        
        if params.count > 0, let parameterizedURL = add(params: params, to: url) {
            composedURL = parameterizedURL
        }
        
        session.dataTask(with: composedURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
    
    private func add(params: [URLQueryItem], to url: URL) -> URL? {
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = params
        return urlComponents?.url
    }
}
