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
    
    /// This delegate method works when the Currency Type changes....
    func selectedData(exchangeModel: ExchangeModel) {

        exchangeComponent?.mainAmountTextField.text = nil
        (presenter as? ExchangeViperModuleInterface)?.updatedExchangeCurrencyCodeType(exchangeModel: exchangeModel)


    }
    
    /// with this method, check validation and go to confirm page.
    func exchangeAction() {
        
        if self.selectedTextFielcValue != "" && self.selectedTextFielcValue != nil && self.selectedTextFielcValue != BaseConstants.zero {
            
            var exchangeModel = (self.pageData as? ExchangeModel)
            exchangeModel?.selectedText = self.selectedTextFielcValue
            
            self.pageData = exchangeModel
            
            guard let finalAmount = exchangeModel?.finalAmount else {
                UIManager.instance.alertView(message: BaseConstants.exchangeButtonValidation, controller: self)
                return
            }
            
            let message = String(format: BaseConstants.confirmMessage,(exchangeModel?.totalCurrency)!,(exchangeModel?.mainCurrencyCode)!, (exchangeModel?.selectedText)!)
            
            UIManager.instance.alertViewConfirm(message: message, controller: self)
            
        }else {
            UIManager.instance.alertView(message: BaseConstants.warringMessage, controller: self)
        }
    }
    
    /// When main currency selected
    func mainCurrencyAction() {

        var exchangeModel = self.pageData as? ExchangeModel
        exchangeModel?.selectedCurrencyType = true
        
        UIManager.instance.alertTableViewController(data: exchangeModel, controller: self)
    }
    
    /// when convertion currency selected
    func convertedCurrencyAction() {
        
        var exchangeModel = self.pageData as? ExchangeModel
        exchangeModel?.selectedCurrencyType = false
        
        UIManager.instance.alertTableViewController(data: exchangeModel, controller: self)
    }

    /// TextFieldDelegate methods
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.selectedTextFielcValue = textField.text
        (presenter as? ExchangeViperModuleInterface)?.conversionRatesCalculate(amount: self.selectedTextFielcValue)
    }
    
    /// Go to the approval status page......
    func goToConfirmPage() {
        (presenter as? ExchangeViperModuleInterface)?.goToConfirmPage(exchangeModel: self.pageData as? ExchangeModel)
    }
    
    /// Currency is calculated and displayed to the user after the final Amount has been calculated...
    @objc func doneClicked() {
        view.endEditing(true)
        (presenter as? ExchangeViperModuleInterface)?.reloadCreateComponent()
   }
}
