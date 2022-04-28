//
//  ContentManager.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

public class TableViewCellModel: NSObject {
    
   public var componentList: [ViewObjectModel]!
    
   public var sectionList: [TableViewSectionModel]!
    
   public var header: ViewObjectModel?
     
   public var footer: ViewObjectModel?
    
   convenience public init(_ componentList:[ViewObjectModel]?) {
        self.init()
        self.componentList = componentList
       
        self.header = getHeaderFooter(type: .header)
        self.footer = getHeaderFooter(type: .footer)
        self.sectionList = getSectionList()
    }
    
    
    func getComponentList(type: ComponentType? = nil, section: Int?) -> [ViewObjectModel]?{
       
        return componentList.filter(){
            if let type = type {
                return $0.section == section && $0.type == type
            }
            else {
                return $0.section == section
            }
        }
    }
    
    func getHeaderFooter(type: ComponentType, section: Int? = nil) -> ViewObjectModel?{
        if let compList = getComponentList(type: type, section: section){
            return compList.last
        }
        return nil
    }
    
    func getSectionList() -> [TableViewSectionModel]{
        let sections = getSections()
        
        var list = Array<TableViewSectionModel>()
        for section in sections{
            if let compList = getComponentList(section: section){
                list.append(TableViewSectionModel(componentList: compList))
            }
        }
        return list
    }
    
    func getSections() -> [Int]{
        var set = Set<Int>()
        for comp in componentList{
            if let section = comp.section{
                set.insert(section)
            }
        }
        return set.sorted()
    }
}
