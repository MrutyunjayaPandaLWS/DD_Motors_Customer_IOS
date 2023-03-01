//
//  DD_DealershipLocationTVC.swift
//  DD_Motors
//
//  Created by Arokia-M3 on 23/12/22.
//

import UIKit
protocol LocationRedirectDelegate: class{
    func didTapMap(_ cell: DD_DealershipLocationTVC)
}

class DD_DealershipLocationTVC: UITableViewCell {

    @IBOutlet var dealerNameLbl: UILabel!
    @IBOutlet var customerNameLbl: UILabel!
    
    @IBOutlet weak var redirectBtn: UIButton!
    
    @IBOutlet var locationHeadLbl: UILabel!
    
    @IBOutlet var managerHeadLbl: UILabel!
    
    @IBOutlet var contactPersionMobileNumberLbl: UILabel!
    
    @IBOutlet var locationHeadMobileNumberLbl: UILabel!
    
    @IBOutlet var managerHeadMobilenumberLbl: UILabel!
    
    @IBOutlet var addressLbl: UILabel!
    
    var delegate: LocationRedirectDelegate!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func contactPersionBTN(_ sender: Any) {
    }
    
    @IBAction func locationContactBTN(_ sender: Any) {
    }
    @IBAction func managerContactBTN(_ sender: Any) {
    }
    
    
    @IBAction func locationRedirectBtn(_ sender: Any) {
        self.delegate.didTapMap(self)
    }
    
    
}
