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
        searchController: UISearchController,
        searchResultViewController: SearchResultViewController
    ) -> SearchViewController {
        let viewController = SearchViewController(
            searchViewController: searchController,
            searchResultViewController: searchResultViewController
        )
        searchController.searchBar.delegate = viewController
        return viewController
    }
    
    public static func searchResultComposedWith(
        searchRepository: SearchRespository
    ) -> SearchResultViewController {
        return SearchResultViewController(
            viewModel: .init(repository: searchRepository)
        )
    }
}
