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
    var controller: UIViewController?
    override func getViewData(data: Any?, controller: UIViewController) {
        self.controller = controller
        self.getAllEventsMethod()
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
        
        
        compList.append(DefaultCurrencyComponent.getViewObjectModel(
            viewData: DefaultCurrencyComponentModel(defaultCurrencyName:self.responseBaseModel?.baseCode,controller:self.controller),
            data: nil,
            parameterName: #keyPath(MainViperViewController.defaultCurrencyComponent),
            section: 0,
            selectedData: nil))
        
        for conversionRatesModel in (self.responseBaseModel?.conversionRatesList)! {
            
            compList.append(CurrencyAmountComponent.getViewObjectModel(
                viewData: CurrencyAmountComponentModel.init(currencyName:conversionRatesModel.currencyName ,currencyAmount:"\(String(describing: (conversionRatesModel.currencyRate)!))",controller:self.controller),
                data: nil,
                parameterName: #keyPath(MainViperViewController.currencyAmountComponent),
                section: 2,
                selectedData: nil))
            
        }
        
        
        presenter.gotViewData(data: nil, model: TableViewCellModel(compList))
    }
}

extension MainViperInteractor: MainViperInteractorInput{

}
