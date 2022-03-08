//
//  SearchResultView.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 08-03-22.
//

import SwiftUI

final public class SearchResultView: UIView {
    
    public var loadingView: UIView = {
        let loadingView = UIHostingController(rootView: LoadingView()).view
        loadingView?.isHidden = true
        loadingView?.translatesAutoresizingMaskIntoConstraints = false
        return loadingView ?? UIView()
    }()
    
    public var errorView: UIView = UIView()
    
    public var productListView: UIView = {
        let productListView = UIHostingController(rootView: ProductListView()).view
        productListView?.isHidden = true
        productListView?.translatesAutoresizingMaskIntoConstraints = false
        return productListView ?? UIView()
    }()
    
    private var searchResultErrorViewUpdater: SearchResultErrorViewUpdater?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        
        addSubview(productListView)
        NSLayoutConstraint.activate([
            productListView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productListView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productListView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            productListView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
