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
}

extension ExchangeViperPresenter: ExchangeViperInteractorOutput{
    
}
