//
//  DD_TabbarVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import UIKit

class DD_TabbarVC: UITabBarController {
    let layerGradient = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        layerGradient.colors = [UIColor(named: "Tabbar")?.cgColor, UIColor(named: "Tabbar")?.cgColor]
        layerGradient.startPoint = CGPoint(x: 0, y: 0.5)
        layerGradient.endPoint = CGPoint(x: 1, y: 0.5)
        layerGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 60)
        self.tabBar.layer.insertSublayer(layerGradient, at: 0)
    }
 
}
