//
//  SearchViewController.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 05-03-22.
//

import UIKit
import SwiftUI

final public class SearchView: UIView {
}

final public class SearchViewController: UIViewController {
    private let viewTitle = "CoolFinder"
    lazy var baseView: SearchView = {
        let baseView = SearchView()
        baseView.backgroundColor = .green
        return baseView
    }()
    
    public override func loadView() {
        view = baseView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController(title: viewTitle)
    }
    
    public func didTapSuggestionView() {
        self.navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
    
    public func didTapReturnKey() {
        self.navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
    
    private func setUpNavigationController(title: String) {
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        let navBarHexColor: Int = 0xf6f6f6
        appearance.backgroundColor = UIColor(hex: navBarHexColor)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance =
        navigationController?.navigationBar.standardAppearance
    }
}

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

extension Color {
    public init(hex: Int) {
        self.init(UIColor(hex: hex))
   }
}
