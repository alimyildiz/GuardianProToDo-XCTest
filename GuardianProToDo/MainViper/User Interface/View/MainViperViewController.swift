//
//  MainViperViewController.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/26/22.
//
//

import UIKit

class MainViperViewController: BViperViewController{

    @objc var currencyComponent: CurrencyComponent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = BaseConstants.currencyListTitle
    }
    
    /// #Seçilen para birimi ile
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard self.pageData != nil else {
            return
        }
        
        let supportedCodesList = (self.pageData as? [[SupportedCodes]])
        
        if let currencyModel = supportedCodesList?[indexPath.row].first {
            
            (presenter as? MainViperModuleInterface)?.goToExchangePage(currencyCode: currencyModel.currencyShortName)
        }
    }
}

extension MainViperViewController: MainViperViewInterface{
    
}
