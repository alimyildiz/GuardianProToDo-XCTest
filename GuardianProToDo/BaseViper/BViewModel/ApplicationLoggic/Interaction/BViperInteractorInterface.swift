//
//  BViperInteractorInterface.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/26/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import UIKit

public protocol BViperInteractorInput: AnyObject {
    func getViewData(data: Any?, controller:UIViewController)
}

public protocol BViperInteractorOutput: AnyObject {
    func gotViewData(data: Any?,model:TableViewCellModel?)
}
