//
//  ConfirmViperInteractor.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/28/22.
//
//

import Foundation
import UIKit

class ConfirmViperInteractor: BViperInteractor
{
    var exchangeModel:ExchangeModel?
    var controller: UIViewController?
    
    override func getViewData(data: Any?, controller: UIViewController) {
        
        self.controller = controller
        self.exchangeModel = data as? ExchangeModel
        createComponents()
    }
    
    func createComponents() {
        var compList = [ViewObjectModel]()
        
        
        compList.append(ConfirmComponent.getViewObjectModel(
            viewData: ConfirmComponentModel(currencyInformation: String(format: "%@ %@ = %@",(self.exchangeModel?.selectedText)!,(self.exchangeModel?.mainCurrencyCode)!,(self.exchangeModel?.totalCurrency)!),delegate:self.controller),
            data: nil,
            section: 0,
            selectedData: nil))
        
        
        presenter.gotViewData(data: nil, model: TableViewCellModel(compList))
    }
}

extension ConfirmViperInteractor: ConfirmViperInteractorInput{

}
