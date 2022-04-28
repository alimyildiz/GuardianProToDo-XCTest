//
//  ConfirmComponent.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/28/22.
//

import UIKit

struct ConfirmComponentModel {
    
    var currencyInformation: String?
    var delegate: UIViewController?
    
    init(currencyInformation: String?, delegate: UIViewController?) {
        self.delegate = delegate
        self.currencyInformation = currencyInformation
    }
}

class ConfirmComponent: BBaseTableViewCell {

    @IBOutlet weak var successIcon: UIImageView!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var delegate: UIViewController?

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
        
        if let model = self.baseObject.viewData as? ConfirmComponentModel {
            
            self.successLabel.text = BaseConstants.success
            self.backButton.setTitle(BaseConstants.backToExchange, for: .normal)
            self.successIcon.image = UIImage(named: "checkBoxIcon")
            self.infoLabel.text = model.currencyInformation
            self.delegate = model.delegate
        }
    }
    
    @IBAction func backActionButton(_ sender: Any) {
        self.delegate?.navigationController?.popViewController(animated: true)
    }
}
