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
    private let apiSupportedCodesEndpoint = "/v6/183032f027c6376ec447ee31/codes"

    
    var responseBaseModel: ResponseBaseModel?
    var currencyListModel: CurrencyListModel?
    var rateData: Data?
    
    var completionHandler: (() -> Void)?
    
    //MARK: Service Get Executer
    func getSupportedCodes(success: @escaping (CurrencyListModel?)->(), failure: @escaping (Error?) -> ()) {
        
        let dataModel = ContentManager.instance.getObjectFromUserDefaults(key: "SupportedCodes") as? Data
        let lastDate = ContentManager.instance.getObjectFromUserDefaults(key: "LastDate") as? String
        
        if dataModel != nil && lastDate != nil {
            
            let currentDate = DateUtils.instance.calculateHours(from: DateUtils.instance.convertStringToDate(dateString: lastDate!))
            
            // 24 constant tanımlanacak...
            if currentDate >= 24 {
                self.executerSupportedCodes() {
                    success(self.currencyListModel)
                }
            }else {
                // 24 saatten küçük durumlarda...
                self.setSupportedCodeModel(dataModel: dataModel as? Data)
                success(self.currencyListModel)
            }
        }else {
            // Hiç kayıt yapılmadıysa burası çalışır...
            self.executerSupportedCodes() {
                success(self.currencyListModel)
            }
        }
    }
    
    
    func executerSupportedCodes(completionHandler: @escaping () -> Void) {
    
        self.completionHandler = completionHandler
                    
        let _URL = URL(string: baseUrlString + apiSupportedCodesEndpoint)!
        var request = URLRequest(url: _URL)
                
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let rateDataModel = data {
                self.rateData = rateDataModel
                
                self.setSupportedCodeModel(dataModel: rateDataModel)

                // Güncel data set edilir...
                ContentManager.instance.setObjectInUserDefaults(object: self.rateData, forKey: "SupportedCodes")
               
                // Güncel Saat Set edilir...
                ContentManager.instance.setObjectInUserDefaults(object: DateUtils.instance.getCurrentDate(), forKey: "LastDate")
                self.completionHandler!()

            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    
    }
    
    
    func getEvents(currency:String?,success: @escaping (ResponseBaseModel?)->(), failure: @escaping (Error?) -> ()) {
        
        let dataModel = ContentManager.instance.getObjectFromUserDefaults(key: currency!) as? Date
        let lastDate = ContentManager.instance.getObjectFromUserDefaults(key: "LastDate") as? String
        
        if dataModel != nil && lastDate != nil {
            
            let currentDate = DateUtils.instance.calculateHours(from: DateUtils.instance.convertStringToDate(dateString: lastDate!))
            
            // 24 constant tanımlanacak...
            if currentDate >= 24 {
                self.executerCurrencyRate(currency: currency) {
                    success(self.responseBaseModel!)
                }
            }else {
                // 24 saatten küçük durumlarda...
                self.setResponseModel(dataModel: dataModel as? Data)
                success(self.responseBaseModel!)
            }
        }else {
            // Hiç kayıt yapılmadıysa burası çalışır...
            self.executerCurrencyRate(currency: currency) {
                 success(self.responseBaseModel!)
            }
        }
    }
    
    func executerCurrencyRate(currency:String?,completionHandler: @escaping () -> Void) {
        
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
                    ContentManager.instance.setObjectInUserDefaults(object: self.rateData, forKey: currency!)
                   
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
    
    func setSupportedCodeModel(dataModel: Data?)  {
        do {
            self.currencyListModel = try! JSONDecoder().decode(CurrencyListModel.self, from: dataModel!)
        }catch let error {
            print(error.localizedDescription)
        }
    }
}

