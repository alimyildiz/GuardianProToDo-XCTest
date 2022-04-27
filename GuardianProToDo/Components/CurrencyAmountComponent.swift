//
//  CurrencyAmountComponent.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

struct CurrencyAmountComponentModel {
    
    var currencyName: String?
    var currencyAmount: String?

    var controller: UIViewController?
    
    init(currencyName: String? = nil ,currencyAmount: String? = nil,controller: UIViewController? = nil){
        
        self.currencyName = currencyName
        self.currencyAmount = currencyAmount
        self.controller = controller
    }
}
class CurrencyAmountComponent: BBaseTableViewCell {

    @IBOutlet weak var currencyAmount: UILabel!
    @IBOutlet weak var currencyName: UILabel!
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
        
        if let model = self.baseObject.viewData as? CurrencyAmountComponentModel {
            self.currencyAmount.text = model.currencyAmount
            self.currencyName.text = model.currencyName

        }
    }
    
}
