//
//  SearchRespository.swift
//  Coolfinder
//
//  Created by Luis Zapata on 04-03-22.
//

import Foundation

public typealias SearchResult = Result<[Product], Error>

public protocol SearchRespository {
    func search(term: String, completion: @escaping ((SearchResult) -> Void))
}
