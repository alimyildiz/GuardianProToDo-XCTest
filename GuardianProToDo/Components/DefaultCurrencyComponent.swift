//
//  DefaultCurrencyComponent.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

struct DefaultCurrencyComponentModel {
    
    var defaultCurrencyName: String?
    var controller: UIViewController?
    
    init(defaultCurrencyName: String? = nil ,controller: UIViewController? = nil){
        self.defaultCurrencyName = defaultCurrencyName
        self.controller = controller
    }
}

public class DefaultCurrencyComponent: BBaseTableViewCell {

    @IBOutlet weak var defaultCurrencyLabel: UILabel!
    @IBOutlet weak var defaultAmountLabel: UILabel!
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
        
        if let model = self.baseObject.viewData as? DefaultCurrencyComponentModel {
            self.defaultAmountLabel.text = "1"
            self.defaultCurrencyLabel.text = model.defaultCurrencyName
        }
    }
    
}
