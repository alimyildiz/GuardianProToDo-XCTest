//
//  AlertTableViewController.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

protocol CustomAlertViewDelegate {
    func selectedData(exchangeModel: ExchangeModel)
}

class AlertTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var alertTableView: UITableView!
    @IBOutlet weak var alertView: UIView!
    
    var dataModel: ExchangeModel?
    var delegate: CustomAlertViewDelegate?

    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alertTableView.dataSource = self
        self.alertTableView.delegate = self
           
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        
        let tableViewCell = UINib(nibName: "AlertTableViewCell",
                                  bundle: nil)
        self.alertTableView.register(tableViewCell,
                                forCellReuseIdentifier: "AlertTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    /// #TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataModel?.responseBaseModel?.conversionRatesList.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AlertTableViewCell") as? AlertTableViewCell {
            
            let currencyCode = dataModel?.responseBaseModel?.conversionRatesList[indexPath.row].currencyName

            if (dataModel?.selectedCurrencyType)! {// main selecteD
                if (dataModel?.responseBaseModel?.conversionRatesList.count)! > 0 {

                    if currencyCode == (dataModel?.mainCurrencyCode)! {
                        
                        print("\(String(describing: currencyCode))" + "=" + ( dataModel?.mainCurrencyCode)!)

                        cell.checkBoxIcon.image = UIImage(named: "checkBoxIcon")
                    }else {
                        cell.checkBoxIcon.image = nil
                    }
                    cell.currencyNameLabel.text = currencyCode
                }
            }else {//converted currrency
                
                if (dataModel?.responseBaseModel?.conversionRatesList.count)! > 0 {
                    print(dataModel?.randomConvertCurrencyCode)

                    if currencyCode == (dataModel?.randomConvertCurrencyCode)! {
                        cell.checkBoxIcon.image = UIImage(named: "checkBoxIcon")
                    }else {
                        cell.checkBoxIcon.image = nil
                    }
                    cell.currencyNameLabel.text = currencyCode
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let currencyCode = dataModel?.responseBaseModel?.conversionRatesList[indexPath.row].currencyName {
            if (dataModel?.selectedCurrencyType)! {// main selected
                dataModel?.mainCurrencyCode = currencyCode
            }else {//converted currency
                dataModel?.randomConvertCurrencyCode = currencyCode
            }
            
            self.delegate?.selectedData(exchangeModel: dataModel!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @IBAction func onTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapOkButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
