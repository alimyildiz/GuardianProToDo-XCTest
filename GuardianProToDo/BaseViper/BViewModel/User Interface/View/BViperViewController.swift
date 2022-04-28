//
//  BViperViewController.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

open class BViperViewController: BTableViewController {

    public var presenter: BViperModuleInterface!
    public var pageData: Any?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.statusBarBackgroundColor()
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
    
    
    /// status bar will set backgroundcolor
    func statusBarBackgroundColor(){
        if #available(iOS 13, *)
          {
              let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = .red
              UIApplication.shared.keyWindow?.addSubview(statusBar)
          } else {
             // ADD THE STATUS BAR AND SET A CUSTOM COLOR
             let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
             if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = #colorLiteral(red: 0.2346, green: 0.3456, blue: 0.5677, alpha: 1)
             }
             UIApplication.shared.statusBarStyle = .lightContent
          }
    }
}

extension BViperViewController: BViperViewControllerInterface {

    public func reloadTableView(pageData: Any?,model:TableViewCellModel) {
        self.pageData = pageData
        data = model
    }
}
