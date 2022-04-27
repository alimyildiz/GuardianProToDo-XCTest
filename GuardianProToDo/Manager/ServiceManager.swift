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
        
    private let baseUrlString = "https://v6.exchangerate-api.com"
    private let apiEndpoint = "/v6/183032f027c6376ec447ee31/latest/"
    
    var responseBaseModel: ResponseBaseModel?
    var rateData: Data?
    
    var completionHandler: (() -> Void)?
    
    //MARK: Service Get Executer
    func getEvents(currency:String?,success: @escaping (ResponseBaseModel?)->(), failure: @escaping (Error?) -> ()) {
        
        let dataModel = ContentManager.instance.getObjectFromUserDefaults(key: "CurrencyRateModel")
        let lastDate = ContentManager.instance.getObjectFromUserDefaults(key: "LastDate") as? String
        
        if dataModel != nil && lastDate != nil {
            
            let currentDate = DateUtils.instance.calculateHours(from: DateUtils.instance.convertStringToDate(dateString: lastDate!))
            
            // 24 constant tanımlanacak...
            if currentDate >= 24 {
                self.executer(currency: currency) {
                    success(self.responseBaseModel!)
                }
            }else {
                // 24 saatten küçük durumlarda...
                self.setResponseModel(dataModel: dataModel as? Data)
                success(self.responseBaseModel!)
            }
        }else {
            // Hiç kayıt yapılmadıysa burası çalışır...
            self.executer(currency: currency) {
                 success(self.responseBaseModel!)
            }
        }
    }
    
    func executer(currency:String?,completionHandler: @escaping () -> Void) {
        
        if let currencyEndpoint = currency {
            self.completionHandler = completionHandler
                        
            let _URL = URL(string: baseUrlString + apiEndpoint + currencyEndpoint)!
            var request = URLRequest(url: _URL)
                    
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let rateDataModel = data {
                    self.rateData = rateDataModel
                    
                    self.setResponseModel(dataModel: rateDataModel)

                    // Güncel data set edilir...
                    ContentManager.instance.setObjectInUserDefaults(object: self.rateData, forKey: "CurrencyRateModel")
                   
                    // Güncel Saat Set edilir...
                    ContentManager.instance.setObjectInUserDefaults(object: DateUtils.instance.getCurrentDate(), forKey: "LastDate")
                    self.completionHandler!()

                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            task.resume()
            
        } else {
            // uyarı verilecek
        }
    }
    
    func setResponseModel(dataModel: Data?)  {
        do {
            self.responseBaseModel = try! JSONDecoder().decode(ResponseBaseModel.self, from: dataModel!)
        }catch let error {
            print(error.localizedDescription)
        }
    }
}

