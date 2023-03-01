//
//  DD_SubscriptionHistoryTVC.swift
//  DD_Motors
//
//  Created by Arokia-M3 on 24/12/22.
//

import UIKit

class DD_SubscriptionHistoryTVC: UITableViewCell {

    @IBOutlet var dateOfSubcriptionLbl: UILabel!
    @IBOutlet var subscribedLbl: GradientLabel!
    @IBOutlet var subcriptionHistoryID: UILabel!
    @IBOutlet var paymentStatus: UILabel!
    
    @IBOutlet var amountPaidLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
