//
//  AppDelegate.swift
//  CoolFinderApp
//
//  Created by Luis Zapata on 06-03-22.
//

import UIKit
import CoolFinderiOS
import Coolfinder
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .default))
    }()
    private lazy var remoteURL = "https://api.mercadolibre.com/sites/MLA/search"
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow()
        window?.tintColor = .orange
        window?.rootViewController = makeRootViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func makeRootViewController() -> UIViewController {
        let remoteURL = URL(string: remoteURL)
        let searchResultVC = AppComposer.searchResultComposedWith(
            searchRepository: RemoteSearchRespository(
                url: remoteURL ?? .init(fileURLWithPath: ""),
                httpClient: httpClient
            )
        )
        
        let uiSearch = UISearchController(searchResultsController: nil)
        return UINavigationController(
            rootViewController: AppComposer.searchComposedWith(
                searchController: uiSearch,
                searchResultViewController: searchResultVC
            )
        )
    }
}
