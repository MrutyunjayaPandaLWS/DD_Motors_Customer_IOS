//
//  DD_MyOffersDetailsPopUp.swift
//  DD_Motors
//
//  Created by ADMIN on 14/02/2023.
//

import UIKit

class DD_MyOffersDetailsPopUp: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)

        }
    }

    
    @IBAction func navigateToSubscription(_ sender: Any) {
        NotificationCenter.default.post(name: .navigateToSubscription, object: nil)
        self.dismiss(animated: true)
    }
    

}
