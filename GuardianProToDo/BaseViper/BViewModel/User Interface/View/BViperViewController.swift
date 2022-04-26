//
//  BViperViewController.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/26/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import UIKit

open class BViperViewController: BTableViewController {

    public var presenter: BViperModuleInterface!
    public var pageData: Any?
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        if presenter != nil {
            presenter.showView(viewController: self)
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         /* if presenter != nil {
                presenter.showView(viewController: self)
          }*/
    }
}

extension BViperViewController: BViperViewControllerInterface {

    public func reloadTableView(pageData: Any?,model:TableViewCellModel) {
        self.pageData = pageData
        data = model
    }
}
