//
//  DD_MyOffersCVC.swift
//  DD_Motors
//
//  Created by ADMIN on 24/12/2022.
//

import UIKit

protocol InfoDelegate: AnyObject{
    func didTapButton(_ cell: DD_MyOffersCVC)
}
class DD_MyOffersCVC: UICollectionViewCell {
    
    @IBOutlet weak var enableOfferImage: UIImageView!
    @IBOutlet weak var scratchView: UIView!
    @IBOutlet weak var lockerView: UIView!
    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var lockedImage: UIImageView!
    @IBOutlet weak var detailsBtb: UIButton!
    
    @IBOutlet weak var cartNumberLbl: UILabel!
    @IBOutlet weak var offerImage: UIImageView!
    
    @IBOutlet weak var offersTitleLbl: UILabel!
    
    @IBOutlet weak var expiredLbl: UILabel!
    var delegate: InfoDelegate!
    
    @IBAction func offersDetailsBtn(_ sender: Any) {
        self.delegate.didTapButton(self)
    }
    
}

//offersTitleLbl
//cartNumberLbl

