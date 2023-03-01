//
//  DD_SubscribePopUp.swift
//  DD_Motors
//
//  Created by ADMIN on 26/12/2022.
//

import UIKit

class DD_SubscribePopUp: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)

        }
    }
    @IBAction func subscribeBtn(_ sender: Any) {
        
        NotificationCenter.default.post(name: .navigateSubscription, object: nil)
        self.dismiss(animated: true)
    }
}
