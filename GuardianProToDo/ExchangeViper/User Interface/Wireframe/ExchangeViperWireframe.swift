//
//  ExchangeViperWireframe.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//
//

import UIKit

public class ExchangeViperWireframe: BViperWireframe{

}

extension ExchangeViperWireframe: ExchangeViperWireframeInterface{
    
    func goToConfirmPage(exchangeModel: ExchangeModel?) {
        
        let wireFrame = ConfirmViperWireframe(dataValue: exchangeModel)
        wireFrame.showController(fromController: controller)
    }
}
