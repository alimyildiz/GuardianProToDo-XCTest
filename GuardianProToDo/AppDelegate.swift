//
//  AppDelegate.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/26/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = self.createModule()
        window?.makeKeyAndVisible()
        return true
    }
    
    // MARK: MainViper created
    func createModule() -> UINavigationController {
        
        let viewController = MainViperWireframe().controller!
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.backgroundColor = .red
        
        return navigationController
    }
}

