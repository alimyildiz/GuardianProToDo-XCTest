//
//  ViewObjectModel.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
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
    public var type: ComponentType!
    public var headerHeight: CGFloat?
    public var footerHeight: CGFloat?

    
    convenience public init(viewName:String?,
                            viewData: Any?,
                            data: Any?,
                            parameterName: String? = nil,
                            indexPath:IndexPath? = nil,
                            type: ComponentType = .component,
                            headerHeight: CGFloat? = nil,
                            footerHeight: CGFloat? = nil,
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
        self.type = type
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
    }
}
