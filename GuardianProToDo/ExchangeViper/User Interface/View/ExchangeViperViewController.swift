//
//  ExchangeViperViewController.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//
//

import UIKit

class ExchangeViperViewController: BViperViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Exchange"
    }
}

extension ExchangeViperViewController: ExchangeViperViewInterface,ExchangeComponentDelegate,UITextFieldDelegate, CustomAlertViewDelegate {
   
    /// Currency Type değiştiğinde bu delegate methodu çalışır...
    func selectedData(exchangeModel: ExchangeModel) {
        (presenter as? ExchangeViperModuleInterface)?.updatedExchangeCurrencyCodeType(exchangeModel: exchangeModel)
    }
    
    
    func exchangeAction() {
        
    }
    
    func mainCurrencyAction() {
        
        var exchangeModel = self.pageData as? ExchangeModel
        exchangeModel?.selectedCurrencyTye = true
        
        UIManager.instance.alertTableViewController(data: exchangeModel, controller: self)
    }
    
    func convertedCurrencyAction() {
        
        var exchangeModel = self.pageData as? ExchangeModel
        exchangeModel?.selectedCurrencyTye = false
        
        UIManager.instance.alertTableViewController(data: exchangeModel, controller: self)
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
}
