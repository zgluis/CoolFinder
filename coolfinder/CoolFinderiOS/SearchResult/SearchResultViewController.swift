//
//  SearchResultViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit
import Coolfinder
import SwiftUI

final public class SearchResultViewController: UIViewController {
    
    public lazy var baseView: SearchResultView = {
        let baseView = SearchResultView(frame: .zero, delegate: self)
        baseView.backgroundColor = UIColor(hex: 0xEDEDED)
        return baseView
    }()
    
    public override func loadView() {
        view = baseView
    }
        
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
        baseView.loadingView.isHidden = false
        viewModel?.search()
        refreshViewTitle()
    }
    
    func bind() {
        viewModel?.onLoadingStateChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.baseView.loadingView.isHidden = !isLoading
            }
        }

        viewModel?.onErrorStateChange = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.baseView.displayErrorMessage(errorMessage)
            }
        }
        
        viewModel?.onProductsLoad = { [weak self] products in
            DispatchQueue.main.async {
                self?.baseView.updateProductList(products)
            }
        }
        viewModel?.onSearchTermChange = { [weak self] _ in
            DispatchQueue.main.async {
                self?.refreshViewTitle()
            }
            self?.viewModel?.search()
        }
    }
    
    public func updateSearchTerm(_ term: String) {
        viewModel?.updateSearchTerm(term)
    }
    
    private func refreshViewTitle() {
        title = viewModel?.searchTerm
    }
}

extension SearchResultViewController: ProductListViewDelegate {
    public func didTapProduct(_ product: Product) {
        self.navigationController?.pushViewController(
            UIHostingController(rootView: ProductDetailView(product: product)),
            animated: true
        )
    }
}
