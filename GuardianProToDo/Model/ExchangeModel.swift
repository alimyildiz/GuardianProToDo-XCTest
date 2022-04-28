//
//  ExchangeModel.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import Foundation

struct ExchangeModel {
    var responseBaseModel: ResponseBaseModel?
    var randomConvertCurrencyCode: String?
    var randomConvertCurrencyAmount: String?
    var mainCurrencyCode: String?
    var mainCurrencyAmount: String?
    var finalAmount: String?
    var totalCurrency: String?
    var currencyInfo: String?
    var selectedText: String?
    var selectedNewCurrencyType: Bool = false
    var selectedCurrencyType: Bool? = false
}
