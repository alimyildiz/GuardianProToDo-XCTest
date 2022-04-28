//
//  NavigationManager.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

public class NavigationManager: NSObject {
    
    static public func pushViewController(from: UIViewController, to: UIViewController, animated: Bool = true) {
       
        if let navigationController = from.navigationController {
            navigationController.navigationBar.isHidden = false
            navigationController.navigationBar.topItem?.title = ""
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.isTranslucent = true
            navigationController.view.backgroundColor = .clear
            navigationController.navigationBar.tintColor = .white
            navigationController.pushViewController(to, animated: true)
        }
    }
}
