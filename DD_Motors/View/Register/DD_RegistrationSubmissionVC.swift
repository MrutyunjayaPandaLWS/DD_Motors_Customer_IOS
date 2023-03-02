//
//  DD_RegistrationSubmissionVC.swift
//  DD_Motors
//
//  Created by ADMIN on 13/02/2023.
//

import UIKit

class DD_RegistrationSubmissionVC: BaseViewController {

    @IBOutlet weak var subView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        subView.clipsToBounds = false
        subView.layer.cornerRadius = 16
        
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    

    @IBAction func backToLogin(_ sender: Any) {
        NotificationCenter.default.post(name: .goToLogin, object: nil)
        self.dismiss(animated: true)
    }
   
}
