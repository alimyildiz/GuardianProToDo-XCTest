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
}

protocol ExchangeViperInteractorOutput: BViperInteractorOutput{

}
