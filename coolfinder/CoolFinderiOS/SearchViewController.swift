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
    lazy var baseView: SearchView = {
        let baseView = SearchView()
        return baseView
    }()
    
    public override func loadView() {
        view = baseView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func didTapSuggestionView() {
        self.navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
    
    public func didTapReturnKey() {
        self.navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
}
