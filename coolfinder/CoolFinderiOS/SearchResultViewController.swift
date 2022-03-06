//
//  SearchResultViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit

public protocol Repository {
    
}

final public class SearchResultViewController: UIViewController {
    private var repository: Repository?
    
    public convenience init(repository: Repository) {
        self.init()
        self.repository = repository
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
