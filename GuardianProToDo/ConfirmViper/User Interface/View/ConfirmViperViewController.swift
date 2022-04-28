//
//  ConfirmViperViewController.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/28/22.
//
//

import UIKit

class ConfirmViperViewController: BViperViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
    }

    func hideNavigationBar(animated: Bool){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension ConfirmViperViewController: ConfirmViperViewInterface{
    
}
