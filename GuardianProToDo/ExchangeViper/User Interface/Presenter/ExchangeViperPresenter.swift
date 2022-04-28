//
//  ExchangeViperPresenter.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//
//

import Foundation

class ExchangeViperPresenter: BViperPresenter{

}

extension ExchangeViperPresenter: ExchangeViperModuleInterface{
    func updatedExchangeCurrencyCodeType(exchangeModel:ExchangeModel?) {
        
        (interactor as? ExchangeViperInteractorInput)?.updatedExchangeCurrencyCodeType(exchangeModel: exchangeModel)
    }
    
    func conversionRatesCalculate(amount: String?) {
        (interactor as? ExchangeViperInteractorInput)?.conversionRatesCalculate(amount: amount)
    }
}

extension ExchangeViperPresenter: ExchangeViperInteractorOutput{
    
    func goToConfirmPage(exchangeModel: ExchangeModel?) {
        (wireFrame as? ExchangeViperWireframeInterface)?.goToConfirmPage(exchangeModel: exchangeModel)
    }
}
