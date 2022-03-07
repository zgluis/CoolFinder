//
//  AppDelegate.swift
//  CoolFinderApp
//
//  Created by Luis Zapata on 06-03-22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow()
        let rootViewController = UIViewController()
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        return true
    }
}
