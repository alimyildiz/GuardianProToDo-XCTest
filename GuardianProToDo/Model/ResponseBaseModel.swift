//
//  ResponseBaseModel.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/27/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import Foundation

struct ResponseBaseModel: Codable {
    
    var timeLastUpdateUTC: String?
    var timeNextUpdateUTC: String?
    var baseCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case timeLastUpdateUTC = "time_last_update_utc"
        case timeNextUpdateUTC = "time_next_update_utc"
        case baseCode = "base_code"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timeLastUpdateUTC = try container.decode(String.self, forKey: .timeLastUpdateUTC)
        self.timeNextUpdateUTC = try container.decode(String.self, forKey: .timeNextUpdateUTC)
        self.baseCode = try container.decode(String.self, forKey: .baseCode)

    }
    
    func encode(to encode: Encoder) throws {
        var container = encode.container(keyedBy: CodingKeys.self)
        try container.encode(timeLastUpdateUTC, forKey: .timeLastUpdateUTC)
        try container.encode(timeNextUpdateUTC, forKey: .timeNextUpdateUTC)
        try container.encode(baseCode, forKey: .baseCode)
    }
}
