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

extension ExchangeViperViewController: ExchangeViperViewInterface,ExchangeComponentDelegate,UITextFieldDelegate {
    
    func exchangeAction() {
        
    }
    
    func mainCurrencyAction() {
        
       /* var usernameTextField: UITextField?

        let promptController = UIAlertController(title: "Username", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let username = usernameTextField?.text {
                //self.downloadRepositories(username)
            }
        }
        promptController.addAction(okAction)
        promptController.addChild(<#T##childController: UIViewController##UIViewController#>)
        present(promptController, animated: true, completion: nil)*/
        
        
        UIManager.instance.alertTableViewController(controller: self)
        
        
    }
    
    func convertedCurrencyAction() {
        
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
}
