//
//  SearchResultViewModel.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 06-03-22.
//

import Foundation
import Coolfinder

final public class SearchResultViewModel {
    typealias Observer<T> = (T) -> Void

    private var searchTerm: String = ""
    private var repository: SearchRespository
    
    var onLoadingStateChange: Observer<Bool>?
    var onProductsLoad: Observer<[Product]>?
    var onErrorStateChange: Observer<String?>?
    
    public init(repository: SearchRespository) {
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
            case .success:
                self.onErrorStateChange?(nil)
                self.onProductsLoad?([])
            }
        })
    }
    
    func updateSearchTerm(_ term: String) {
        searchTerm = term
    }
}
