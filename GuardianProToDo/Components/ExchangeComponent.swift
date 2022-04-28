//
//  ExchangeComponent.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

protocol ExchangeComponentDelegate {
    func exchangeAction()
    func mainCurrencyAction()
    func convertedCurrencyAction()
}

struct ExchangeComponentModel {
    
    var mainCurrencyCodeName: String?
    var convertedCurrencyCodeName: String?
    var finalAmount: String?
    var currencyInfo: String?
    var delegate: UIViewController?
    var selectedNewCurrencyType: Bool?
    
    init(mainCurrencyCodeName: String? = nil, convertedCurrencyCodeName: String? = nil, finalAmount: String? = nil, currencyInfo: String? = nil, selectedNewCurrencyType: Bool? = false, delegate: UIViewController?) {
        self.mainCurrencyCodeName = mainCurrencyCodeName
        self.convertedCurrencyCodeName = convertedCurrencyCodeName
        self.finalAmount = finalAmount
        self.currencyInfo = currencyInfo
        self.delegate = delegate
        self.selectedNewCurrencyType = selectedNewCurrencyType
    }
}

public class ExchangeComponent: BBaseTableViewCell {

    @IBOutlet weak var mainCurrencyButton: UIButton!
    
    @IBOutlet weak var convertedCurrencyButton: UIButton!
    
    @IBOutlet weak var mainAmountTextField: UITextField!
    
    @IBOutlet weak var finalAmountLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var exchangeButton: UIButton!
    
    var delegate: ExchangeComponentDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func exchangeActionButton(_ sender: Any) {
        self.delegate?.exchangeAction()
    }
    
    @IBAction func mainCurrencyActionButton(_ sender: Any) {
        self.delegate?.mainCurrencyAction()
    }
    
    @IBAction func convertedCurrencyActionButton(_ sender: Any) {
        self.delegate?.convertedCurrencyAction()
    }
    
    override public func createViewObject(baseObject: Any!, indexPath: IndexPath) {
        super.createViewObject(baseObject: baseObject, indexPath: indexPath)
        
        if let model = self.baseObject.viewData as? ExchangeComponentModel {

            self.delegate = (model.delegate as? ExchangeComponentDelegate)
            
            infoLabel.text = model.currencyInfo
            infoLabel.layer.borderColor = UIColor.darkGray.cgColor
            infoLabel.layer.borderWidth = 1.0
            infoLabel.layer.cornerRadius = 9.0
            
            mainCurrencyButton.setTitle(model.mainCurrencyCodeName, for: .normal)
            convertedCurrencyButton.setTitle(model.convertedCurrencyCodeName, for: .normal)
            
            finalAmountLabel.text = model.finalAmount
            
            exchangeButton.setTitle(BaseConstants.exchange, for: .normal)
            
            mainAmountTextField.delegate = (model.delegate as? UITextFieldDelegate)
            mainAmountTextField.text = model.selectedNewCurrencyType! ? nil:mainAmountTextField.text
            mainAmountTextField.resignFirstResponder()
            
            if model.selectedNewCurrencyType! {
                mainAmountTextField.text = nil
            }
        }
    }
}
