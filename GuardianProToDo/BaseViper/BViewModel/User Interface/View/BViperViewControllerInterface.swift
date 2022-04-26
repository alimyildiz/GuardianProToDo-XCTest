//
//  BViperViewControllerInterface.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/26/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import UIKit

public protocol BViperViewControllerInterface:AnyObject {
    func reloadTableView(pageData: Any?, model:TableViewCellModel) 
}
