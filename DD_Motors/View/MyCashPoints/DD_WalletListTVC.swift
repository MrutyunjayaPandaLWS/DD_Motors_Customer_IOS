//
//  DD_WalletListTVC.swift
//  DD_Motors
//
//  Created by ADMIN on 23/12/2022.
//

import UIKit

class DD_WalletListTVC: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var pointsLbl: UILabel!
    
    @IBOutlet weak var infoLbl: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
