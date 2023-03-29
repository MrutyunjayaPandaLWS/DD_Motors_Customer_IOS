//
//  AccountDeactivatePopUpVC.swift
//  DD_Motors
//
//  Created by ADMIN on 29/03/2023.
//

import UIKit

class AccountDeactivatePopUpVC: BaseViewController {

    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subView: UIView!
    var itsFrom = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        subView.clipsToBounds = false
        subView.layer.cornerRadius = 16
        
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        if itsFrom == "DeleteAccount"{
            self.titleLbl.text = "Deleted!!"
            self.subTitleLbl.text = "Your account has been deleted. Kindly contact your administrator!"
        }
    }
    @IBAction func okButton(_ sender: Any) {
        if itsFrom == "DeleteAccount"{
            NotificationCenter.default.post(name: .deleteAccount, object: nil)
        }else{
            NotificationCenter.default.post(name: .accountDeactivated, object: nil)
        }
        self.dismiss(animated: true)
    }
    
}
