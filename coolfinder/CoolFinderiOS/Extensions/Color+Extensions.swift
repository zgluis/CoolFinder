//
//  Color+Extensions.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 07-03-22.
//

import Foundation
import SwiftUI

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

extension Color {
    public init(hex: Int) {
        self.init(UIColor(hex: hex))
   }
}
