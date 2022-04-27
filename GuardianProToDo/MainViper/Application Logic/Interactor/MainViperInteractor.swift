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
    var responseBaseModel: ResponseBaseModel?
    var currencyListModel: CurrencyListModel?

    var controller: UIViewController?
    override func getViewData(data: Any?, controller: UIViewController) {
        self.controller = controller
        
        getSupportedCodes()
       // self.getAllEventsMethod()
    }
    
    func getSupportedCodes(){
        ServiceManager.sharedService.getSupportedCodes { data in
            self.currencyListModel = data
            self.createComponents()
        } failure: { error in
            print("error: \(error)")
        }
    }
    
    //Get ALL Events
    func getAllEventsMethod() {

        ServiceManager.sharedService.getEvents(currency: "USD") { data in
            self.responseBaseModel = data
            self.createComponents()
        } failure: { error in
            print("error: \(error)")
        }
    }
    
    func createComponents() {
        var compList = [ViewObjectModel]()
        
        for supportedCode in (self.currencyListModel?.supportedCodesList)! {
            
            compList.append(CurrencyComponent.getViewObjectModel(
                viewData: CurrencyComponentModel(currencyShortName:supportedCode.first?.currencyShortName ,currencyFullName:"\(String(describing: (supportedCode.first?.currencyFullName)!))",controller:self.controller),
                data: nil,
                parameterName: #keyPath(MainViperViewController.currencyComponent),
                section: 0,
                selectedData: nil))
        }
        
        presenter.gotViewData(data: nil, model: TableViewCellModel(compList))
    }
}

extension MainViperInteractor: MainViperInteractorInput{

}
