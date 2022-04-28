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
            
            self.exchangeModel.randomConvertCurrencyAmount = String(describing: (self.exchangeModel.responseBaseModel?.conversionRatesList.first?.currencyRate)!)
            
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
                                             selectedNewCurrencyType: self.exchangeModel.selectedNewCurrencyType,
                                             delegate: self.controller!),
                data: exchangeModel,
                parameterName: #keyPath(ExchangeViperViewController.exchangeComponent),
                section: 0,
                selectedData: nil))
        
        presenter.gotViewData(data: self.exchangeModel, model: TableViewCellModel(compList))
    }
}

extension ExchangeViperInteractor: ExchangeViperInteractorInput {
    
    func updatedExchangeCurrencyCodeType(exchangeModel: ExchangeModel?) {
        
        //The screen will be cleared when a new selection is made.
        self.exchangeModel = exchangeModel!
        self.exchangeModel.finalAmount = nil
        self.exchangeModel.selectedNewCurrencyType = true
        
        if (self.exchangeModel.selectedCurrencyType)! {
            self.getAllEventsMethod(currencyCode: self.exchangeModel.mainCurrencyCode)
        }else {
            self.updateCurrencyInfo()
            self.createComponents()
        }
    }
    
    /// Update edilen currency name'lere göre info label güncellenir...
    func updateCurrencyInfo() {
        
        self.exchangeModel.currencyInfo = BaseConstants.defaultAmount + String(describing: (self.exchangeModel.mainCurrencyCode)!) + " = " + "\((self.exchangeModel.randomConvertCurrencyAmount)!)" + " " + (self.exchangeModel.randomConvertCurrencyCode)!
    }
    /// Conversion Rates Calculate
    func conversionRatesCalculate(amount: String?) {
        
        let totalCurrency = AmountUtils.instance.conversionRatesWillCalculate(currentAmount: amount, convertedCurrencyName: self.exchangeModel.randomConvertCurrencyCode, convertedCurrencyRate: self.exchangeModel.randomConvertCurrencyAmount)
       
        self.exchangeModel.selectedNewCurrencyType = false
        self.exchangeModel.finalAmount = BaseConstants.finalAmount + totalCurrency
        self.exchangeModel.totalCurrency = totalCurrency
    }
    
    func reloadCreateComponent() {
        self.createComponents()
    }
}
