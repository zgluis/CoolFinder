//
//  Localized.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 07-03-22.
//

import Foundation

final class Localized {
    static var bundle: Bundle {
        Bundle(for: Localized.self)
    }
}

extension Localized {
    enum Search {
        static var searchVCTitle: String {
            NSLocalizedString(
                "search.searchVCTitle",
                tableName: "",
                bundle: bundle,
                comment: "App Name"
            )
        }
    }
}
