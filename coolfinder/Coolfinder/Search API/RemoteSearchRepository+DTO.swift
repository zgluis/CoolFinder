//
//  RemoteSearchRepository+DTO.swift
//  Coolfinder
//
//  Created by Luis Zapata on 05-03-22.
//

import Foundation

extension RemoteSearchRespository {

    // MARK: - SearchResponse
    struct SearchResponse: Codable {
        let results: [RemoteProduct]
        
        func toProducts() -> [Product] {
            return results.map({ Product(
                id: $0.id,
                title: $0.title,
                price: $0.price,
                thumbnail: $0.thumbnail,
                installments: .init(
                    quantity: $0.installments.quantity,
                    amount: $0.installments.amount))
            })
        }
    }
    
    // MARK: - Result
    struct RemoteProduct: Codable {
        let id: String
        let title: String
        let price: Double
        let thumbnail: String
        let installments: Installments
    }

    // MARK: - Installments
    struct Installments: Codable {
        let quantity: Int
        let amount: Double
    }
}
