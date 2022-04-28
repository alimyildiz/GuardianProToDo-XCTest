//
//  ExchangeViperInteractorInterface.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//
//

import Foundation

protocol ExchangeViperInteractorInput: BViperInteractorInput{
    func updatedExchangeCurrencyCodeType(exchangeModel:ExchangeModel?)
    func conversionRatesCalculate(amount: String?)
    func reloadCreateComponent()
}

protocol ExchangeViperInteractorOutput: BViperInteractorOutput{

}
