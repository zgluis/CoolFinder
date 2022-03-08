//
//  SearchResultView.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 08-03-22.
//

import SwiftUI

public struct LoadingView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            Text("Loading..")
        }
    }
}

final public class SearchResultView: UIView {
    
    public var loadingView: UIView = {
        let loadingView = UIHostingController(rootView: LoadingView()).view
        loadingView?.isHidden = true
        loadingView?.translatesAutoresizingMaskIntoConstraints = false
        return loadingView ?? UIView()
    }()
        
    public var errorView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    public var productListView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView() {
        addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
