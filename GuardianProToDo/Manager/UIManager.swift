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
    
    func alertView(message:String?,controller:UIViewController) {
        
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) {
                   _ in
                   print("Cancel Pressed")
        }

        alert.addAction(cancelAction)

        controller.present(alert, animated: true, completion: nil)
    }
    
    func alertViewConfirm(message:String?, controller:UIViewController) {
        
        self.delegate = controller as? AlertViewDelegate
        
        let alert = UIAlertController(title: "Warning!", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                   _ in
                   print("Cancel Pressed")
        }
         
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) {
           _ in
            self.delegate?.goToConfirmPage()
        }

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)

        controller.present(alert, animated: true, completion: nil)
    }
    
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
}

