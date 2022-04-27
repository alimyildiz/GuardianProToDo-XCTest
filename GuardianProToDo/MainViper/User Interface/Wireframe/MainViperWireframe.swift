//
//  MainViperWireframe.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/26/22.
//
//

import UIKit

public class MainViperWireframe: BViperWireframe{

}

extension MainViperWireframe: MainViperWireframeInterface{
   
    func goToExchangePage(currencyCode: String?) {
        
        let wireFrame = ExchangeViperWireframe(dataValue: currencyCode)
        wireFrame.showController(fromController: controller)
    }
}
