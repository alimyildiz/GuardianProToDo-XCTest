//
//  BViperInteractorInterface.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

public protocol BViperInteractorInput: AnyObject {
    func getViewData(data: Any?, controller:UIViewController)
}

public protocol BViperInteractorOutput: AnyObject {
    func gotViewData(data: Any?,model:TableViewCellModel?)
}
