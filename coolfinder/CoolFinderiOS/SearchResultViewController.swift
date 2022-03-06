//
//  SearchResultViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit
import Coolfinder

final public class SearchResultViewModel {
    typealias Observer<T> = (T) -> Void

    private var searchTerm: String
    private var repository: SearchRespository
    
    var onLoadingStateChange: Observer<Bool>?
    var onProductsLoad: Observer<[Product]>?
    var onErrorStateChange: Observer<String?>?
    
    public init(searchTerm: String = "", repository: SearchRespository) {
        self.searchTerm = searchTerm
        self.repository = repository
    }
    
    func search() {
        onLoadingStateChange?(true)
        repository.search(term: searchTerm, completion: { [weak self] result in
            guard let self = self else { return }
            self.onLoadingStateChange?(false)
            switch result {
            case .failure:
                self.onErrorStateChange?("")
            default:
                self.onErrorStateChange?(nil)
            }
        })
    }
}

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
    }
    
    func bind() {
        viewModel?.onLoadingStateChange = { [weak self] isLoading in
            self?.loadingView.isHidden = !isLoading
        }

        viewModel?.onErrorStateChange = { [weak self] errorMessage in
            self?.errorView.isHidden = errorMessage == nil
        }
    }
}
