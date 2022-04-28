//
//  MainViperInteractor.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/26/22.
//
//

import Foundation
import UIKit

class MainViperInteractor: BViperInteractor
{
    var currencyListModel: CurrencyListModel?
    var controller: UIViewController?
    
    override func getViewData(data: Any?, controller: UIViewController) {
        self.controller = controller
        
        getSupportedCodes()
    }
    
    func getSupportedCodes(){
        ServiceManager.sharedService.getSupportedCodes { data in
            self.currencyListModel = data
            
            DispatchQueue.main.async {
                self.createComponents()
            }
            
        } failure: { error in
            print("error: \(error)")
        }
    }
    
    func createComponents() {
        var compList = [ViewObjectModel]()
        
        for supportedCode in (self.currencyListModel?.supportedCodesList)! {
            
            compList.append(CurrencyComponent.getViewObjectModel(
                viewData: CurrencyComponentModel(currencyShortName:supportedCode.first?.currencyShortName ,currencyFullName:"\(String(describing: (supportedCode.first?.currencyFullName)!))",controller:self.controller),
                data: self.currencyListModel?.supportedCodesList,
                parameterName: #keyPath(MainViperViewController.currencyComponent),
                section: 0,
                selectedData: nil))
        }
        
        presenter.gotViewData(data: self.currencyListModel?.supportedCodesList, model: TableViewCellModel(compList))
    }
}

extension MainViperInteractor: MainViperInteractorInput{

}
