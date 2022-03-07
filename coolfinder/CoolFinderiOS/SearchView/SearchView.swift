//
//  SearchView.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 07-03-22.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didTapSuggestion(term: String)
}

final public class SearchView: UIView {
    let productHint = "Motorola"
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Localized.Search.searchViewHintTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Localized.Search.searchViewHintSubtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var hintButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(getAttributedHint(), for: .normal)
        button.isEnabled = true
        button.addTarget(self, action: #selector(didTapHint), for: .touchUpInside)
        return button
    }()
    
    lazy var stackIconsView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalCentering
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
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
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        addSubview(stackIconsView)
        NSLayoutConstraint.activate([
            stackIconsView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            stackIconsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0)
        ])
        stackIconsView.addArrangedSubview(subTitleLabel)
        stackIconsView.addArrangedSubview(hintButton)
    }
    
    private func getAttributedHint() -> NSAttributedString {
        var labelText = productHint
        labelText.append("?")
        let attributedText = NSMutableAttributedString(
            string: labelText
        )
        let range = NSString(string: labelText).range(of: productHint)
        let highlightedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.orange
        ]
        attributedText.addAttributes(highlightedAttributes, range: range)
        return attributedText
    }
    
    @objc private func didTapHint() {
        delegate?.didTapSuggestion(term: productHint)
    }
}
