//
//  ExchangeViperModuleInterface.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//
//

import Foundation
protocol ExchangeViperModuleInterface: BViperModuleInterface{
    func updatedExchangeCurrencyCodeType(exchangeModel: ExchangeModel?)
    func conversionRatesCalculate(amount: String?)
    func goToConfirmPage(exchangeModel: ExchangeModel?)
    func reloadCreateComponent() 
}
