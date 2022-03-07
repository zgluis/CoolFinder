//
//  SearchView.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 07-03-22.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    
}

final public class SearchView: UIView {
    
    var delegate: SearchViewDelegate?
    
    convenience init(frame: CGRect, delegate: SearchViewDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView() {
        
    }
}
