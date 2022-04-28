//
//  AmountUtils.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/28/22.
//

import UIKit

class AmountUtils: NSObject {

    public static var instance: AmountUtils = AmountUtils()
    
    // MARK: - Currency Calculated
    func conversionRatesWillCalculate(currentAmount: String?,convertedCurrencyName: String?,convertedCurrencyRate: String?) -> String {
        
        let amount =  currentAmount!.isEmpty ? 0:Int(currentAmount!)
        let currencyRate = Double(convertedCurrencyRate!)
        let totalCurrency = Double(amount == nil ? 0:amount!) * currencyRate!
        
        return  currencyFormatting(convertedCurrencyRate: String(describing: totalCurrency), currencyCode: convertedCurrencyName)
    }
    
    func currencyFormatting(convertedCurrencyRate:String?, currencyCode: String?) -> String {
        if let value = Double(convertedCurrencyRate!) {
             
             let formatter = NumberFormatter()
             formatter.numberStyle = .currency
             formatter.maximumFractionDigits = 2
             formatter.minimumFractionDigits = 2
            
             formatter.locale = self.locale(from: currencyCode!)
            
             if let str = formatter.string(for: value) {
                 return str
             }
         }
         return ""
     }
    
    func locale(from currencyCode: String) -> Locale {
        var locale = Locale.current
        if (locale.currencyCode != currencyCode) {
            let identifier = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode])
            locale = NSLocale(localeIdentifier: identifier) as Locale
        }
        return locale;
    }

}
