//
//  ExchangeViperViewController.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//
//

import UIKit

class ExchangeViperViewController: BViperViewController{

    @objc var exchangeComponent: ExchangeComponent?
    var selectedTextFielcValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = BaseConstants.exchangeTitle
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension ExchangeViperViewController: ExchangeViperViewInterface,ExchangeComponentDelegate,UITextFieldDelegate, CustomAlertViewDelegate,AlertViewDelegate {
    
    /// Currency Type değiştiğinde bu delegate methodu çalışır...
    func selectedData(exchangeModel: ExchangeModel) {
        exchangeComponent?.mainAmountTextField.becomeFirstResponder()
        exchangeComponent?.mainAmountTextField.text = nil
        (presenter as? ExchangeViperModuleInterface)?.updatedExchangeCurrencyCodeType(exchangeModel: exchangeModel)
    }
    
    func exchangeAction() {

        if self.selectedTextFielcValue != "" && self.selectedTextFielcValue != nil && self.selectedTextFielcValue != BaseConstants.zero {
            
            var finalAmount = (self.pageData as? ExchangeModel)
            finalAmount?.selectedText = self.selectedTextFielcValue
            
            self.pageData = finalAmount
            
            let message = String(format: BaseConstants.confirmMessage,(finalAmount?.totalCurrency)!,(finalAmount?.mainCurrencyCode)!, (finalAmount?.selectedText)!)
            
            UIManager.instance.alertViewConfirm(message: message, controller: self)
        }else {
            UIManager.instance.alertView(message: BaseConstants.warringMessage, controller: self)
        }
    }
    
    func mainCurrencyAction() {

        var exchangeModel = self.pageData as? ExchangeModel
        exchangeModel?.selectedCurrencyType = true
        
        UIManager.instance.alertTableViewController(data: exchangeModel, controller: self)
    }
    
    func convertedCurrencyAction() {
        
        var exchangeModel = self.pageData as? ExchangeModel
        exchangeModel?.selectedCurrencyType = false
        
        UIManager.instance.alertTableViewController(data: exchangeModel, controller: self)
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.selectedTextFielcValue = textField.text
        (presenter as? ExchangeViperModuleInterface)?.conversionRatesCalculate(amount: self.selectedTextFielcValue)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    func goToConfirmPage() {
        (presenter as? ExchangeViperModuleInterface)?.goToConfirmPage(exchangeModel: self.pageData as? ExchangeModel)
    }
}
