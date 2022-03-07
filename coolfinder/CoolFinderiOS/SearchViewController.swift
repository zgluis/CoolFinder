//
//  SearchViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit

final public class SearchView: UIView {
}

final public class SearchViewController: UIViewController {
    private let viewTitle = "CoolFinder"
    lazy var baseView: SearchView = {
        let baseView = SearchView()
        baseView.backgroundColor = .green
        return baseView
    }()
    
    public override func loadView() {
        view = baseView
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
    }
}
