//
//  BBaseTableViewCell.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/27/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import UIKit

@objc public protocol DelegateProtocol {
    var controller:UIViewController? {get set}
}
public protocol BComponentModelProtocol {
    func createWithObject(cell:BBaseTableViewCell,baseObject:Any!,indexPath:IndexPath)
}

@objcMembers
@objc open class BComponentModel: NSObject, BComponentModelProtocol {
 
    public var title:String?
    public var subTitle:String?
    public var imageURL:String?
    
    public init(title:String? = nil,subTitle:String? = nil,imageURL:String? = nil){
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
    
    public func createWithObject(cell: BBaseTableViewCell, baseObject: Any!, indexPath: IndexPath) {
        cell.createViewObject(baseObject: baseObject, indexPath: indexPath)
     }

}

open class BBaseTableViewCell: UITableViewCell,DelegateProtocol {

    public var controller: UIViewController?
    public var baseObject: ViewObjectModel!
    public var indexPath: IndexPath!
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //Cell'e ait olduğu tableview döner.
    open var tableView:UITableView? {
        get {
            return (controller as? UITableViewController)?.tableView
        }
    }
    
    //Tableview'in üst view(süperview)'ini döner
    open var containerView:UIView? {
        get {
            return tableView?.superview
        }
    }
    
    open func createViewObject(baseObject:Any!,indexPath: IndexPath) {
        self.baseObject = baseObject as? ViewObjectModel
        self.indexPath = indexPath
        self.baseObject.indexPath = indexPath
    }
    
    public static func getViewObjectModel(viewData:Any? = BComponentModel(),data:Any?,parameterName:String? = nil,section:Int? = 0,selectedData:Any? = nil) -> ViewObjectModel {

        return ViewObjectModel(viewName: description(), viewData: viewData, data: data, parameterName: parameterName, section: section, selectedData: selectedData)
    }

}
