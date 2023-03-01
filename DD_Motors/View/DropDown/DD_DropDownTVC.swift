//
//  DD_DropDownTVC.swift
//  DD_Motors
//
//  Created by ADMIN on 24/12/2022.
//

import UIKit

class DD_DropDownTVC: UITableViewCell {

    @IBOutlet weak var selectedItemLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
