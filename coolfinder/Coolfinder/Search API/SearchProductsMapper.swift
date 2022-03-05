//
//  SearchProductsMapper.swift
//  Coolfinder
//
//  Created by Luis Zapata on 05-03-22.
//

import Foundation

final class SearchProductsMapper {
    // MARK: - DTO
    
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
    
    private static var httpValidCodes: ClosedRange<Int> { return 200...299 }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteSearchRespository.Result {
        guard httpValidCodes.contains(response.statusCode),
            let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
            return .failure(.invalidData)
        }

        return .success(response.toProducts())
    }
}
