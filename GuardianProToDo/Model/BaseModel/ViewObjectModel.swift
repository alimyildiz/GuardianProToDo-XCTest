//
//  ViewObjectModel.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/28/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import UIKit

public class ViewObjectModel: NSObject {
    public static var compList: [ViewObjectModel]?
    public var viewData: Any?
    public var data: Any?
    public var parameterName: String?
    public var section: Int?
    public var selectedData: Any?
    public var viewName: String?
    public var indexPath: IndexPath?
    
    convenience public init(viewName:String?,
                            viewData: Any?,
                            data: Any?,
                            parameterName: String? = nil,
                            indexPath:IndexPath? = nil,
                            section: Int? = 0,
                            selectedData: Any? = nil) {
        self.init()
        
        self.viewData = viewData
        self.data = data
        self.parameterName = parameterName
        self.selectedData = selectedData
        self.section = section
        self.viewName = viewName
        self.indexPath = indexPath
    }
}
