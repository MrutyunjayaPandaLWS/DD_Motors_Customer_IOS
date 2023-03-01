//
//  DD_SupportTVC.swift
//  DD_Motors
//
//  Created by ADMIN on 23/12/2022.
//

import UIKit

class DD_SupportTVC: UITableViewCell {

    @IBOutlet weak var helpTopicLbl: UILabel!
    
    @IBOutlet weak var queryDetailsLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var ticketStatusLbl: UILabel!
    
    @IBOutlet weak var customerTicketRefNoLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
