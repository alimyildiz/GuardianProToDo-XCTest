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
    override func getViewData(data: Any?, controller: UIViewController) {
       // createComponents(data)
        self.getAllEventsMethod()
    }
    
    //Get ALL Events
    func getAllEventsMethod() {
        

        ServiceManager.sharedService.getEvents(currency: "usd") { data in
            print("data: \(data)")
            
     
            
          /*  if let events = value["events"] as? [[String: Any?]] {
                self.eventsList = [EventsModel]()

                for item in events {
                    
                    self.eventModel = Mapper<EventsModel>().map(JSON: item as [String : Any])
                    self.eventsList?.append(self.eventModel!)
                }
                self.informationLabel.text = Desciption.informationMessage
                self.tableViewContollerLoad()
            }*/
        } failure: { error in
            print("error: \(error)")
        }
    }
    
    func createComponents(_ data: Any?) {
        var compList = [ViewObjectModel]()
        
        presenter.gotViewData(data: data, model: TableViewCellModel(compList))
    }
}

extension MainViperInteractor: MainViperInteractorInput{

}
