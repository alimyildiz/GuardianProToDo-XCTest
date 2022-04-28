//
//  UIManager.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

protocol AlertViewDelegate {
    func goToConfirmPage()
}

class UIManager: NSObject {
    
    public static let instance:UIManager = UIManager()
    
    var delegate:AlertViewDelegate?
    
    /// Only message AlertView
    func alertView(message:String?,controller:UIViewController) {
        
        let alert = UIAlertController(title: BaseConstants.warningTitle, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: BaseConstants.ok, style: .cancel) {
                   _ in
        }

        alert.addAction(cancelAction)

        controller.present(alert, animated: true, completion: nil)
    }
    
    /// Confirm AlertView
    func alertViewConfirm(message:String?, controller:UIViewController) {
        
        self.delegate = controller as? AlertViewDelegate
        
        let alert = UIAlertController(title: BaseConstants.warningTitle, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: BaseConstants.cancel, style: .cancel) {
                   _ in
        }
         
        let confirmAction = UIAlertAction(title: BaseConstants.confirm, style: .default) {
           _ in
            self.delegate?.goToConfirmPage()
        }

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)

        controller.present(alert, animated: true, completion: nil)
    }
    
    /// Custom AlertView  for tableview single select currency code.
    func alertTableViewController(selectedData:String? = nil, data: Any?, controller: UIViewController) {
        
        let alertViewController = AlertTableViewController.init(nibName: "AlertTableViewController", bundle: nil)
        alertViewController.dataModel = data as? ExchangeModel
        alertViewController.providesPresentationContextTransitionStyle = true
        alertViewController.definesPresentationContext = true
        alertViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        alertViewController.delegate = controller as? CustomAlertViewDelegate
        controller.present(alertViewController, animated: true, completion: nil)
    }
    
    /// Toolbar button textField'e eklenir.Done buttonu ile kullanıcı currency hesabı yapar...
    func toolBar(controller: UIViewController) -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        flexibleSpace.width = controller.view.frame.size.width

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: controller, action: #selector(ExchangeViperViewController.doneClicked))
    
        toolBar.setItems([flexibleSpace,doneButton], animated: false)
        
        return toolBar
    }
}

