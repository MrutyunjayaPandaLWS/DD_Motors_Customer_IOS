//
//  DD_SubscriptionSuccessPopUp.swift
//  DD_Motors
//
//  Created by ADMIN on 13/02/2023.
//

import UIKit

class DD_SubscriptionSuccessPopUp: BaseViewController {

    @IBOutlet weak var subView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        subView.clipsToBounds = false
        subView.layer.cornerRadius = 16
        
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    @IBAction func goToDashBoardBtn(_ sender: Any) {
       
            NotificationCenter.default.post(name: .goToDealerlocation, object: nil)
            self.dismiss(animated: true)
        
    }
}
