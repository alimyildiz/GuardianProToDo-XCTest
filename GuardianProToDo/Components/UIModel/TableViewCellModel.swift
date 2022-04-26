//
//  TableViewCellModel.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/27/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import UIKit

public class TableViewCellModel: NSObject {
    
   public var componentList: [ViewObjectModel]?
    
   convenience public init(_ componentList:[ViewObjectModel]?) {
        self.init()
        self.componentList = componentList
    }
}
