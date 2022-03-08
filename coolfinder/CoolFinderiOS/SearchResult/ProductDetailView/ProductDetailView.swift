//
//  ProductDetailView.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 08-03-22.
//

import SwiftUI
import Coolfinder
public struct ProductDetailView: View {
    var product: Product
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Text(product.title)
                        .font(.largeTitle)
                    Spacer()
                }.padding()
                AsyncImage(url: product.thumbnail) { imagePhase in
                    switch imagePhase {
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 240)
                    default:
                        Rectangle()
                            .foregroundColor(.gray)
                            .frame(height: 240)
                    }
                }
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(String(product.price))
                            .foregroundColor(.black)
                            .font(.title3)
                            .bold()
                        InstallmentsView(
                            quantity: product.installments.quantity,
                            amount: product.installments.amount,
                            style: .large
                        )
                    }.padding()
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(
            product: .init(
                id: "id",
                title: "title",
                price: .zero,
                thumbnail: URL(string: "https://i.stack.imgur.com/ILTQq.png"),
                installments: .init(quantity: .zero, amount: 100))
        )
    }
}
