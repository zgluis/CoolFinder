//
//  SearchViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit
import Coolfinder

final public class SearchViewController: UIViewController {
    private let viewTitle = Localized.Search.searchVCTitle
    lazy var baseView: SearchView = {
        let baseView = SearchView(frame: .zero, delegate: self)
        baseView.backgroundColor = UIColor(hex: 0xEDEDED)
        return baseView
    }()
    
    public override func loadView() {
        view = baseView
    }
    private var searchViewController: UISearchController?
    private var searchResultViewController: SearchResultViewController?
    public convenience init(
        searchViewController: UISearchController,
        searchResultViewController: SearchResultViewController
    ) {
        self.init()
        self.searchViewController = searchViewController
        self.searchResultViewController = searchResultViewController
        definesPresentationContext = true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController(title: viewTitle)
    }
    
    public func didTapReturnKey(term: String) {
        guard let searchResultVC = searchResultViewController else { return }
        searchResultVC.updateSearchTerm(term)
        self.navigationController?.pushViewController(searchResultVC, animated: true)
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
        navigationItem.searchController = searchViewController
    }
}

extension SearchViewController: SearchViewDelegate {
    public func didTapSuggestion(term: String) {
        guard let searchResultVC = searchResultViewController else { return }
        searchResultVC.updateSearchTerm(term)
        self.navigationController?.pushViewController(searchResultVC, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        didTapReturnKey(term: text)
    }
}
