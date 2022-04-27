//
//  MainViperPresenter.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/26/22.
//
//

import Foundation

class MainViperPresenter: BViperPresenter{

}

extension MainViperPresenter: MainViperModuleInterface{
    
}

extension MainViperPresenter: MainViperInteractorOutput{
    func goToExchangePage(currencyCode:String?) {
        
        (wireFrame as? MainViperWireframeInterface)?.goToExchangePage(currencyCode: currencyCode)
    }
}
