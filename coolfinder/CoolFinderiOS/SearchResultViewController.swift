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
    
    public convenience init(repository: SearchRespository) {
        self.init()
        self.repository = repository
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        repository?.search(term: "", completion: { _ in
            
        })
    }
}
