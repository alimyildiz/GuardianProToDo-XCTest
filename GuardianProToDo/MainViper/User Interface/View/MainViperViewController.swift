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
    @objc var currencyAmountComponent: CurrencyAmountComponent?
    override func viewDidLoad() {
        super.viewDidLoad()

       // navBarTitle = "enterKey".localized()
    }
}

extension MainViperViewController: MainViperViewInterface{
    
}
