//
//  ServiceManager.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
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
    /// GET all currency list.
    func getSupportedCodes(success: @escaping (CurrencyListModel?)->(), failure: @escaping (Error?) -> ()) {
        
        let dataModel = ContentManager.instance.getObjectFromUserDefaults(key: BaseConstants.supportedCodesKey) as? Data
        let lastDate = ContentManager.instance.getObjectFromUserDefaults(key: BaseConstants.dateUserDefaultKey) as? String
        
        if dataModel != nil && lastDate != nil {
            
            let currentDate = DateUtils.instance.calculateHours(from: DateUtils.instance.convertStringToDate(dateString: lastDate!))
            
            // In cases greater than 24 hours...
            if currentDate >= Int(BaseConstants.timeLimit)! {
                self.executerSupportedCodes() {
                    success(self.currencyListModel)
                }
            }else {
                // In less than 24 hours...
                self.setSupportedCodeModel(dataModel: dataModel as? Data)
                success(self.currencyListModel)
            }
        }else {
            // This place works if no registration is done...
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

                // Updated data is added...
                ContentManager.instance.setObjectInUserDefaults(object: self.rateData, forKey: BaseConstants.supportedCodesKey)
               
                // Updated hour is added...
                ContentManager.instance.setObjectInUserDefaults(object: DateUtils.instance.getCurrentDate(), forKey: BaseConstants.dateUserDefaultKey)
                self.completionHandler!()

            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    
    }
    
    /// GET all events with currency.
    func getEvents(currency:String?,success: @escaping (ResponseBaseModel?)->(), failure: @escaping (Error?) -> ()) {
        
        let dataModel = ContentManager.instance.getObjectFromUserDefaults(key: currency!) as? Date
        let lastDate = ContentManager.instance.getObjectFromUserDefaults(key: BaseConstants.dateUserDefaultKey) as? String
        
        if dataModel != nil && lastDate != nil {
            
            let currentDate = DateUtils.instance.calculateHours(from: DateUtils.instance.convertStringToDate(dateString: lastDate!))
            
            // In cases greater than 24 hours...
            if currentDate >= Int(BaseConstants.timeLimit)! {
                self.executerCurrencyRate(currency: currency) {
                    success(self.responseBaseModel!)
                }
            }else {
                // In less than 24 hours...
                self.setResponseModel(dataModel: dataModel as? Data)
                success(self.responseBaseModel!)
            }
        }else {
            // This place works if no registration is done...
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

                    // Updated date is added...
                    ContentManager.instance.setObjectInUserDefaults(object: self.rateData, forKey: currency!)
                   
                    // Updated hour is added...
                    ContentManager.instance.setObjectInUserDefaults(object: DateUtils.instance.getCurrentDate(), forKey: BaseConstants.dateUserDefaultKey)
                    self.completionHandler!()

                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            task.resume()
            
        } else {
            print(" // uyarı  mesajı verilecek........")
        }
    }
    
    /// JsonDecoder for currency events
    func setResponseModel(dataModel: Data?)  {
        do {
            self.responseBaseModel = try! JSONDecoder().decode(ResponseBaseModel.self, from: dataModel!)
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    // Currency list JSONDecoding
    func setSupportedCodeModel(dataModel: Data?)  {
        do {
            self.currencyListModel = try! JSONDecoder().decode(CurrencyListModel.self, from: dataModel!)
        }catch let error {
            print(error.localizedDescription)
        }
    }
}

