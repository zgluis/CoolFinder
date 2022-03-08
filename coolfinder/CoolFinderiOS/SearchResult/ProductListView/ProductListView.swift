//
//  ProductListView.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 08-03-22.
//

import SwiftUI
import Coolfinder

protocol ProductListViewUpdater {
    func updateProducts(_ products: [Product])
}

struct ProductListView: View, ProductListViewUpdater {
    @ObservedObject var viewModel = ProductListViewModel()
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(viewModel.products) { product in
                    ProductView(
                        title: product.title,
                        price: product.price,
                        thumbnail: product.thumbnail,
                        installmentsQuantity: product.installments.quantity,
                        installmentsAmount: product.installments.amount
                    )
                }
            }
        }
    }
    
    func updateProducts(_ products: [Product]) {
        viewModel.products = products
    }
}

class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
}

struct ProductListView_Previews: PreviewProvider {
    @Binding var products: [Product]
    
    static var previews: some View {
        let viewModel = ProductListViewModel(
            products: Array(
                repeating: Product(
                    id: UUID().uuidString,
                    title: "Some Title",
                    price: .zero,
                    thumbnail: nil,
                    installments: .init(quantity: .zero, amount: .zero)
                ),
                count: 10
            )
        )
        ProductListView(viewModel: viewModel)
    }
}

private extension ProductListViewModel {
    convenience init(products: [Product]) {
        self.init()
        self.products = products
    }
}
