//
//  DD_NotificationTVC.swift
//  DD_Motors
//
//  Created by ADMIN on 29/12/2022.
//

import UIKit

class DD_NotificationTVC: UITableViewCell {

    @IBOutlet weak var notificationMessageLbl: UILabel!
    @IBOutlet weak var notificationTitleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
