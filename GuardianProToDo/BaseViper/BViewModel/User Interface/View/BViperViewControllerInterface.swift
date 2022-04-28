//
//  BViperViewControllerInterface.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

public protocol BViperViewControllerInterface:AnyObject {
    func reloadTableView(pageData: Any?, model:TableViewCellModel) 
}
