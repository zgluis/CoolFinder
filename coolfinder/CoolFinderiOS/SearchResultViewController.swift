//
//  SearchResultViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit
import Coolfinder
import SwiftUI

public struct LoadingView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            Text("Loading..")
        }
    }
}

final public class SearchResultViewController: UIViewController {
    
    public var errorView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    public var loadingView: UIView = {
        let loadingView = UIHostingController(rootView: LoadingView()).view
        loadingView?.isHidden = true
        loadingView?.translatesAutoresizingMaskIntoConstraints = false
        return loadingView ?? UIView()
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
        self.view.backgroundColor = .green
        self.view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
