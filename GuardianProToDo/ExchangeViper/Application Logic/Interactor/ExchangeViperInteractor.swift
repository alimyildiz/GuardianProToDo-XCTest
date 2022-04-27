//
//  ExchangeViperInteractor.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//
//

import Foundation
import UIKit

class ExchangeViperInteractor: BViperInteractor
{
    var responseBaseModel: ResponseBaseModel?
    var controller: UIViewController?
    var randomConvertCurrency: String?
    var finalAmount: String?
    var currencyInfo: String?

    
    override func getViewData(data: Any?, controller: UIViewController) {
        self.controller = controller
        self.getAllEventsMethod(currencyCode: data as? String)
    }
    
    //Get ALL Currency Events
    func getAllEventsMethod(currencyCode:String?) {

        ServiceManager.sharedService.getEvents(currency: currencyCode) { data in
            self.responseBaseModel = data
            self.randomConvertCurrency = self.responseBaseModel?.conversionRatesList.first?.currencyName
            self.createComponents()
        } failure: { error in
            print("error: \(error)")
        }
    }
    
    func createComponents() {
        var compList = [ViewObjectModel]()
        
        compList.append(ExchangeComponent.getViewObjectModel(
            viewData: ExchangeComponentModel(mainCurrencyCodeName: self.responseBaseModel?.baseCode,
                                             convertedCurrencyCodeName: self.randomConvertCurrency,
                                             finalAmount: self.finalAmount,
                                             currencyInfo: self.currencyInfo,
                                             delegate: self.controller!),
                data: nil,
                section: 0,
                selectedData: nil))
        
        presenter.gotViewData(data: self.responseBaseModel, model: TableViewCellModel(compList))
    }
}

extension ExchangeViperInteractor: ExchangeViperInteractorInput{

}
