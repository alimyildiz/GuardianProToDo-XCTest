//
//  CurrencyListModel.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import Foundation

struct CurrencyListModel: Codable {
    
    private var supportedCodes: [[String]]?
    var result: String?
    var supportedCodesList = [[SupportedCodes]]()
    
    private enum CodingKeys: String, CodingKey {
        case supportedCodes = "supported_codes"
        case result = "result"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.supportedCodes = try container.decode([[String]].self, forKey: .supportedCodes)
        self.result = try container.decode(String.self, forKey: .result)
        
        for item in (self.supportedCodes)! {
            self.supportedCodesList.append([SupportedCodes(currencyShortName: item[0], currencyFullName: item[1])])
        }
    }
    
    func encode(to encode: Encoder) throws {
        var container = encode.container(keyedBy: CodingKeys.self)
        try container.encode(supportedCodes, forKey: .supportedCodes)
    }
}

struct SupportedCodes {
    let currencyShortName: String?
    let currencyFullName: String?
}
