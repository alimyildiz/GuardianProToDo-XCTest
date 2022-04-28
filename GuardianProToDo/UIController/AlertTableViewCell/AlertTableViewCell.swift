//
//  AlertTableViewCell.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

class AlertTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyNameLabel: UILabel!
    
    @IBOutlet weak var checkBoxIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
