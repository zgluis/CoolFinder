//
//  SearchResultViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit
import Coolfinder

final public class SearchResultViewController: UIViewController {
    
    public var errorView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    public var loadingView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    public var productListView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private var viewModel: SearchResultViewModel? {
        didSet {
            bind()
        }
    }
    
    public convenience init(viewModel: SearchResultViewModel) {
        self.init()
        defer {
            self.viewModel = viewModel
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        viewModel?.search()
        title = viewModel?.searchTerm
    }
    
    func bind() {
        viewModel?.onLoadingStateChange = { [weak self] isLoading in
            self?.loadingView.isHidden = !isLoading
        }

        viewModel?.onErrorStateChange = { [weak self] errorMessage in
            self?.errorView.isHidden = errorMessage == nil
        }
        
        viewModel?.onProductsLoad = { [weak self] products in
            self?.productListView.isHidden = false
        }
    }
    
    public func didTapProduct(product: Product) {
        self.navigationController?.pushViewController(ProductDetailViewController(), animated: true)
    }
    
    public func updateSearchTerm(_ term: String) {
        viewModel?.updateSearchTerm(term)
    }
}

final public class ProductDetailViewController: UIViewController {
}
