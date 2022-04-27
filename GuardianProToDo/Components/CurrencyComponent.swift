//
//  CurrencyComponent.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

struct CurrencyComponentModel {
    
    var currencyShortName: String?
    var currencyFullName: String?

    var controller: UIViewController?
    
    init(currencyShortName: String? = nil ,currencyFullName: String? = nil,controller: UIViewController? = nil){
        
        self.currencyShortName = currencyShortName
        self.currencyFullName = currencyFullName
        self.controller = controller
    }
}
class CurrencyComponent: BBaseTableViewCell {

    @IBOutlet weak var currencyFullName: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override public func createViewObject(baseObject: Any!, indexPath: IndexPath) {
        super.createViewObject(baseObject: baseObject, indexPath: indexPath)
        
        if let model = self.baseObject.viewData as? CurrencyComponentModel {
            self.currencyFullName.text = model.currencyFullName

        }
    }
    
}
