//
//  BViperPresenter.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

open class BViperPresenter: BViperModuleInterface {
    
    public var wireFrame: BViperWireFrameInterface!
    public var view: BViperViewControllerInterface!
    public var interactor: BViperInteractorInput!
    
    public var data:Any?
    
    open func showView(viewController:UIViewController) {
        interactor.getViewData(data: data, controller: viewController)
    }
    
    //Navigation function Yazılabilir...
    
    public required init(){
        
    }
}


extension BViperPresenter: BViperInteractorOutput {
    public func gotViewData(data: Any?, model: TableViewCellModel?) {
        self.data = data
        view.reloadTableView(pageData: data, model: model!)
    }
}
