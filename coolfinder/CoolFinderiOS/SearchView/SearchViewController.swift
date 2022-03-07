//
//  SearchViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit
import Coolfinder

final public class SearchViewController: UIViewController {
    private let viewTitle = "CoolFinder"
    lazy var baseView: SearchView = {
        let baseView = SearchView(frame: .zero, delegate: self)
        baseView.backgroundColor = UIColor(hex: 0xEDEDED)
        return baseView
    }()
    
    public override func loadView() {
        view = baseView
    }
    private var searchViewController: UISearchController?
    
    public convenience init(searchViewController: UISearchController) {
        self.init()
        self.searchViewController = searchViewController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController(title: viewTitle)
    }
    
    public func didTapSuggestionView() {
        self.navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
    
    public func didTapReturnKey() {
        self.navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
    
    private func setUpNavigationController(title: String) {
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        let navBarHexColor: Int = 0xf6f6f6
        appearance.backgroundColor = UIColor(hex: navBarHexColor)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance =
        navigationController?.navigationBar.standardAppearance
        navigationItem.searchController = UISearchController(
            searchResultsController: searchViewController
        )
    }
}

extension SearchViewController: SearchViewDelegate {
    
}
