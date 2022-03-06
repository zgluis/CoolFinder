//
//  SearchResultViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit
import Coolfinder

final public class SearchResultViewController: UIViewController {
    private var repository: SearchRespository?
    private var searchTerm: String = ""
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
    
    public convenience init(searchTerm: String, repository: SearchRespository) {
        self.init()
        self.searchTerm = searchTerm
        self.repository = repository
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        repository?.search(term: searchTerm, completion: { [weak self] result in
            guard let self = self else { return }
            self.loadingView.isHidden = true
            switch result {
            case .failure:
                self.errorView.isHidden = false
            default:
                self.errorView.isHidden = true
                break
            }
        })
    }
}
