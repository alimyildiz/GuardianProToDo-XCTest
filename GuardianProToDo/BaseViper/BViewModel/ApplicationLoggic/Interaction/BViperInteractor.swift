//
//  BViperInteractor.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

open class BViperInteractor {
    
    public var presenter: BViperInteractorOutput!
    
    open func getViewData(data: Any?, controller:UIViewController) {
        presenter.gotViewData(data: data,model:TableViewCellModel())
    }
    
    public required init() {
        
    }
}
