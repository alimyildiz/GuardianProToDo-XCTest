//
//  BViperInteractor.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/26/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
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
