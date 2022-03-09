//
//  NavigationController+Spy.swift
//  CoolFinderiOSTests
//
//  Created by Luis Zapata on 06-03-22.
//

import UIKit

class NavigationControllerSpy: UINavigationController {
    private var pushedViewControllers: [UIViewController] = []

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllers.append(viewController)
        super.pushViewController(viewController, animated: false)
    }
    
    func getPushedViewControllers() -> [UIViewController] {
        return pushedViewControllers
    }
}
