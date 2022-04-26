//
//  BTableViewController.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/27/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
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
    
        if data != nil && data.componentList != nil {
            return 1
        }
        return 0
    }

  open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.componentList!.count
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    func createCell(cell:BBaseTableViewCell,baseObject:ViewObjectModel,indexPath:IndexPath) -> BBaseTableViewCell {
        //BaseTableview ulaşabilmek için kullanılır...
        cell.setValue(self, forKey: #keyPath(DelegateProtocol.controller))
        if let model = baseObject.viewData as? BComponentModel {
            model.createWithObject(cell: cell, baseObject: baseObject, indexPath: indexPath)
        }else {
            cell.createViewObject(baseObject: baseObject, indexPath: indexPath)
        }
        
        return cell
    }
    
}
