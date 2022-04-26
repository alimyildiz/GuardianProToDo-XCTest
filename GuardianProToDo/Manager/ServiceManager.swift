//
//  ServiceManager.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/27/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {
    
    public static var sharedService: ServiceManager = ServiceManager()

    var dataModel:[String: Any]?
        
    private let baseUrlString = "https://v6.exchangerate-api.com"
    private let apiEndpoint = "/v6/183032f027c6376ec447ee31/latest/"
    private var currencyEndpoint = ""
    
    var responseBaseModel: ResponseBaseModel?
    
    //MARK: Service Get Executer
    func getEvents(currency:String?,success: @escaping (Data)->(), failure: @escaping (Error?) -> ()) {
        
        // burada 1 günlük saat kontrolü yapılacak
        //Defoult userdan data varsa ve bir gün dolmamış ise defoult userdan tekrar data cekilir...

        if let currencyEndpoint = currency {
            
            self.currencyEndpoint = currencyEndpoint
            
            let _URL = URL(string: baseUrlString + apiEndpoint + currencyEndpoint)!
            var request = URLRequest(url: _URL)
                    
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let rateData = data {
                    
                 /*   let jsonRes = try? JSONSerialization.jsonObject(with: rateData, options: [])
                        print("Response json is: \(jsonRes)")
                        
                        guard let value = jsonRes as? [String: Any] else {
                            return
                        }*/
                    
                    do {
                        
                        self.responseBaseModel = try! JSONDecoder().decode(ResponseBaseModel.self, from: rateData)
                        print((self.responseBaseModel?.baseCode)!)
                    }catch let error {
                        print(error)
                    }
                    
                    
                   // UserDefaults.standard.set(rateData, forKey: "exchangeJsonData") //setObject
 
                  //  let dataModel =  UserDefaults.standard.string(forKey: "exchangeJsonData")

                    // Defoult user'a data basılır....
                    success(rateData)
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            
            task.resume()
        } else {
            // uyarı verilecek
        }
    }
}

