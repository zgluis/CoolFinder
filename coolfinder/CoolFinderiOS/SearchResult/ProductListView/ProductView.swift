//
//  ProductView.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 08-03-22.
//

import SwiftUI

struct ProductView: View {
    let title: String
    let price: Double
    let thumbnail: URL?
    let installmentsQuantity: Int
    let installmentsAmount: Double
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                AsyncImage(url: thumbnail)
                    .frame(width: 132, height: 132)
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                    VStack(alignment: .leading, spacing: 0) {
                        Text(String(price))
                            .foregroundColor(.black)
                            .font(.body)
                        InstallmentsView(quantity: installmentsQuantity, amount: installmentsAmount, style: .normal)
                    }
                    Spacer()
                }
                Spacer()
            }
            Divider()
        }.fixedSize(horizontal: false, vertical: true)
    }
}

struct InstallmentsView: View {
    let quantity: Int
    let amount: Double
    let style: ViewStyle
    
    enum ViewStyle {
        case normal
        case large
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            Text("en ")
                .font(style == .normal ? .caption : .callout)
            Text(self.getInstallmentsText(quantity: quantity, amount: amount))
                .foregroundColor(.orange)
                .bold()
                .font(style == .normal ? .caption : .callout)
        }
    }
    
    private func getInstallmentsText(
        quantity: Int,
        amount: Double
    ) -> String {
        return String(quantity) + "x " + String(amount) + " cuotas"
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(
            title: "Title",
            price: 0,
            thumbnail: nil,
            installmentsQuantity: 4,
            installmentsAmount: 2000
        )
    }
}
