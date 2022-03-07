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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey! What are you up to?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Looking for a Motorola maybe?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        return label
    }()
    
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
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        
        addSubview(subTitleLabel)
        NSLayoutConstraint.activate([
            subTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            subTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0)
        ])
    }
}
