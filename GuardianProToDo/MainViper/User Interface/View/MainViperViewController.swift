//
//  MainViperViewController.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/26/22.
//
//

import UIKit

class MainViperViewController: BViperViewController{

    @objc var defaultCurrencyComponent: DefaultCurrencyComponent?
    @objc var currencyComponent: CurrencyComponent?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Currency List"
       // navBarTitle = "enterKey".localized()
    }
}

extension MainViperViewController: MainViperViewInterface{
    
}
