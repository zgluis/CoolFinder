//
//  AppComposer.swift
//  CoolFinderApp
//
//  Created by Luis Zapata on 09-03-22.
//

import UIKit
import Coolfinder
import CoolFinderiOS

final class AppComposer {
    private init() {}
    
    public static func searchComposedWith(
        searchViewController: UISearchController,
        searchResultViewController: SearchResultViewController
    ) -> SearchViewController {
        return SearchViewController(
            searchViewController: searchViewController,
            searchResultViewController: searchResultViewController
        )
    }
    
    public static func searchResultComposedWith(
        searchRepository: SearchRespository
    ) -> SearchResultViewController {
        return SearchResultViewController(
            viewModel: .init(repository: searchRepository)
        )
    }
}
