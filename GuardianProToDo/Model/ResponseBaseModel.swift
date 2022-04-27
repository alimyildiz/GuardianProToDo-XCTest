//
//  ResponseBaseModel.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/27/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import Foundation

struct ResponseBaseModel: Codable {
    
    typealias UpdateUTC = String
    typealias Name = String

    var timeLastUpdateUTC: UpdateUTC?
    var timeNextUpdateUTC: UpdateUTC?
    var baseCode: Name?
    private var conversionRates: [Name: Double]?
    var conversionRatesList = [ConversionRates]()

    private enum CodingKeys: String, CodingKey {
        case timeLastUpdateUTC = "time_last_update_utc"
        case timeNextUpdateUTC = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timeLastUpdateUTC = try container.decode(String.self, forKey: .timeLastUpdateUTC)
        self.timeNextUpdateUTC = try container.decode(String.self, forKey: .timeNextUpdateUTC)
        self.baseCode = try container.decode(String.self, forKey: .baseCode)
        self.conversionRates = try  container.decode([String:Double].self, forKey: .conversionRates)
        
        for (currencyKey,currencyValue) in (self.conversionRates)! {
            self.conversionRatesList.append(ConversionRates(currencyName: currencyKey, currencyRate: currencyValue))
        }
    }
    
    func encode(to encode: Encoder) throws {
        var container = encode.container(keyedBy: CodingKeys.self)
        try container.encode(timeLastUpdateUTC, forKey: .timeLastUpdateUTC)
        try container.encode(timeNextUpdateUTC, forKey: .timeNextUpdateUTC)
        try container.encode(baseCode, forKey: .baseCode)
        try container.encode(conversionRates, forKey: .conversionRates)
    }
}

struct ConversionRates {
    let currencyName: String?
    let currencyRate: Double?
}
