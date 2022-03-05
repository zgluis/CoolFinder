//
//  Product.swift
//  Coolfinder
//
//  Created by Luis Zapata on 04-03-22.
//

import Foundation

public struct Product: Equatable {
    public let id: String
    public let title: String
    public let price: Double
    public let thumbnail: String
    public let installments: Installments
    
    public init(
        id: String,
        title: String,
        price: Double,
        thumbnail: String,
        installments: Installments
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
        self.installments = installments
    }
}

public struct Installments: Equatable {
    public let quantity: Int
    public let amount: Double
    
    public init(quantity: Int, amount: Double) {
        self.quantity = quantity
        self.amount = amount
    }
}


