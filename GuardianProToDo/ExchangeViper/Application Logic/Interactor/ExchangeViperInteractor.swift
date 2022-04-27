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
    var exchangeModel = ExchangeModel()
    var controller: UIViewController?
     
    override func getViewData(data: Any?, controller: UIViewController) {
        self.controller = controller
        self.getAllEventsMethod(currencyCode: data as? String)
    }
    
    //Get ALL Currency Events
    func getAllEventsMethod(currencyCode:String?) {

        ServiceManager.sharedService.getEvents(currency: currencyCode) { data in
            
            self.exchangeModel.responseBaseModel = data
            
            self.exchangeModel.randomConvertCurrencyCode = (self.exchangeModel.responseBaseModel?.conversionRatesList.first?.currencyName)!
            self.exchangeModel.randomConvertCurrencyAmount = String(describing: self.exchangeModel.responseBaseModel?.conversionRatesList.first?.currencyRate)
            self.exchangeModel.mainCurrencyCode = self.exchangeModel.responseBaseModel?.baseCode
            self.updateCurrencyInfo()
            DispatchQueue.main.async {
                self.createComponents()
            }
            
        } failure: { error in
            print("error: \(error)")
        }
    }
    
    func createComponents() {
        var compList = [ViewObjectModel]()
        
        compList.append(ExchangeComponent.getViewObjectModel(
            viewData: ExchangeComponentModel(mainCurrencyCodeName: self.exchangeModel.mainCurrencyCode,
                                             convertedCurrencyCodeName: self.exchangeModel.randomConvertCurrencyCode,
                                             finalAmount: self.exchangeModel.finalAmount,
                                             currencyInfo: self.exchangeModel.currencyInfo,
                                             delegate: self.controller!),
                data: nil,
                section: 0,
                selectedData: nil))
        
        presenter.gotViewData(data: self.exchangeModel, model: TableViewCellModel(compList))
    }
}

extension ExchangeViperInteractor: ExchangeViperInteractorInput {
    
    func updatedExchangeCurrencyCodeType(exchangeModel: ExchangeModel?) {
        self.exchangeModel = exchangeModel!
        if (self.exchangeModel.selectedCurrencyTye)! {
            self.getAllEventsMethod(currencyCode: self.exchangeModel.mainCurrencyCode)
        }else {
            self.updateCurrencyInfo()
            self.createComponents()
        }
    }
    /// #Update edilen currency name'lere göre info label güncellenir...
    func updateCurrencyInfo() {
        self.exchangeModel.currencyInfo = "1 " + String(describing: (self.exchangeModel.mainCurrencyCode)!) + " = " + self.exchangeModel.randomConvertCurrencyAmount + " " + self.exchangeModel.randomConvertCurrencyCode
    }
}
