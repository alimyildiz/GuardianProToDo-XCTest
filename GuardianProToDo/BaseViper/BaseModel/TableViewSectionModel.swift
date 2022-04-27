//
//  TableViewCellModel.swift
//  GetirTodo
//
//  Created by Alim Yıldız on 4/16/22.
//
//

import UIKit

public class TableViewSectionModel: NSObject {
    
    public var components: [ViewObjectModel]!
    public var componentList: [ViewObjectModel]!
    
    public var header: ViewObjectModel?
    
    public var footer: ViewObjectModel?
    
    public var headerHeight: CGFloat?
    
    public var footerHeight: CGFloat?
    
    convenience public init(componentList:[ViewObjectModel]) {
        self.init()
        
        components = componentList
        self.componentList = getComponentList(type: .component)
        header = getHeaderFooter(type: .header)
        footer = getHeaderFooter(type: .footer)
        
        headerHeight = getHeaderHeight()
        footerHeight = getFooterHeight()
    }
    
    func getComponentList(type: ComponentType) -> [ViewObjectModel]?{
        return components.filter(){
            return $0.type == type
        }
    }
    
    func getHeaderFooter(type: ComponentType) -> ViewObjectModel?{
        if let compList = getComponentList(type: type){
            return compList.last
        }
        
        return nil
    }
    
    func getHeaderHeightModel() -> [ViewObjectModel]?{
        return components.filter(){
            return $0.headerHeight != nil
        }
    }
    
    func getFooterHeightModel() -> [ViewObjectModel]?{
        return components.filter(){
            return $0.footerHeight != nil
        }
    }
    
    func getHeaderHeight() -> CGFloat?{
        if let compList = getHeaderHeightModel()
        {
            return compList.last?.headerHeight
        }
        
        return nil
    }
    
    func getFooterHeight() -> CGFloat?{
        if let compList = getFooterHeightModel()
        {
            return compList.last?.footerHeight
        }
        
        return nil
    }
    
}
