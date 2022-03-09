//
//  SearchResultView.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 08-03-22.
//

import SwiftUI
import Coolfinder

final public class SearchResultView: UIView {
    
    public var loadingView: UIView = {
        let loadingView = UIHostingController(rootView: LoadingView()).view
        loadingView?.isHidden = true
        loadingView?.translatesAutoresizingMaskIntoConstraints = false
        return loadingView ?? UIView()
    }()
    
    public var errorView = UIView()
    public var productListView = UIView()
    
    private var searchResultErrorViewUpdater: SearchResultErrorViewUpdater?
    private var productListViewDelegate: ProductListViewDelegate?
    private var productListViewUpdater: ProductListViewUpdater?
    
    convenience init(frame: CGRect, delegate: ProductListViewDelegate) {
        self.init(frame: frame)
        self.productListViewDelegate = delegate
        configureView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateProductList(_ products: [Product]) {
        if products.isEmpty {
            productListView.isHidden = true
        } else {
            productListView.isHidden = false
            productListViewUpdater?.updateProducts(products)
        }
    }
    
    func displayErrorMessage(_ message: String?) {
        if let message = message {
            errorView.isHidden = false
            searchResultErrorViewUpdater?.updateErrorMessage(message)
        } else {
            errorView.isHidden = true
        }
    }
    
    func configureView() {
        let searchResultErrorView = SearchResultErrorView()
        searchResultErrorViewUpdater = searchResultErrorView
        errorView = UIHostingController(rootView: searchResultErrorView).view
        errorView.isHidden = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let concreteProductListView = ProductListView(delegate: productListViewDelegate)
        productListViewUpdater = concreteProductListView
        productListView = UIHostingController(rootView: concreteProductListView).view
        productListView.isHidden = true
        productListView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(productListView)
        NSLayoutConstraint.activate([
            productListView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productListView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productListView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            productListView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
