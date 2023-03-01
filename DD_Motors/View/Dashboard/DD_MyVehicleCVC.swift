//
//  DD_MyVehicleCVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import UIKit

class DD_MyVehicleCVC: UICollectionViewCell {
    
    @IBOutlet weak var vehicleColorLbl: UILabel!
    @IBOutlet weak var vehicleNamelbl: UILabel!
    @IBOutlet weak var vehicleCompanyLbl: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var vehicleImage: UIImageView!
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.viewAndEditButton.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
        subView.layer.cornerRadius = 6
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.clipsToBounds = true
        
    }
}
