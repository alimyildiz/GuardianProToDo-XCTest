//
//  BTableViewController.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

open class BTableViewController: UITableViewController {
    
    public var isReloadData: Bool = true
    
    public var data: TableViewCellModel! {
        
        didSet {
            
            if self.isReloadData {
                
              //  self.tableView.backgroundColor = .blue
                self.tableView.reloadData()
            }
        }
    }

   open override func viewDidLoad() {
        super.viewDidLoad()
    
    
        /// TableView Properties create edilir....
        tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 25
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 25
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.keyboardDismissMode = .onDrag
        tableView.tintColor = .black
    }

    // MARK: - Table view data source

   open override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       
       if data != nil && data.sectionList != nil {
           return data.sectionList.count
       }
       
       return 0
    }

  open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return data.sectionList[section].componentList.count
  }

   open override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellData = data.componentList?[indexPath.row]
        let cellClass = NSClassFromString((cellData?.viewName)!) as! UITableViewCell.Type
    
        let componentName = getComponentName(cellName: String(describing: cellClass.self), indexPath: indexPath, parameterName: cellData?.parameterName)
    
        tableView.register(cellClass.self, forCellReuseIdentifier: componentName)
        tableView.register(UINib(nibName: String(describing: cellClass.self), bundle: Bundle(for: cellClass)), forCellReuseIdentifier: componentName)
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: componentName, for: indexPath) as? BBaseTableViewCell else {
             
             return UITableViewCell()
         }
    
        return createCell(cell: cell, baseObject: cellData!, indexPath: indexPath)
    }
    
    func getComponentName(cellName:String,indexPath:IndexPath? = nil,parameterName:String? = nil) -> String {
         var name = cellName
        if let index = indexPath {
            name += "_" + String(index.section) + "_" + String(index.row)
        }
        if let paramName = parameterName {
            name += "_" + paramName
        }
        return name
    }
    
    /// BaseTableview ulaşabilmek için kullanılır...
    func createCell(cell:BBaseTableViewCell,baseObject:ViewObjectModel,indexPath:IndexPath) -> BBaseTableViewCell {
        cell.setValue(self, forKey: #keyPath(DelegateProtocol.controller))
        if let model = baseObject.viewData as? BComponentModel {
            model.createWithObject(cell: cell, baseObject: baseObject, indexPath: indexPath)
        }else {
            cell.createViewObject(baseObject: baseObject, indexPath: indexPath)
        }
        
        return cell
    }
    
}
