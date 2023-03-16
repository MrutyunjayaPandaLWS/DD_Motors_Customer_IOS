//
//  DD_PromotionDetailsVC.swift
//  DD_Motors
//
//  Created by syed on 16/03/23.
//

import UIKit
import Lottie

class DD_PromotionDetailsVC: UIViewController {

    @IBOutlet weak var LoaderAnimation: LottieAnimationView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var descriptionDetails: UILabel!
    @IBOutlet weak var promotionInfo: UILabel!
    @IBOutlet weak var promotionNameLbl: UILabel!
    @IBOutlet weak var promotionImage: UIImageView!
    var PromotionDetails: LstPromotionJsonList?
    override func viewDidLoad() {
        super.viewDidLoad()

        loaderView.isHidden = true
        LoaderAnimation.isHidden = true
        configure()
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func configure(){
        
        promotionNameLbl.text = PromotionDetails?.promotionName
        let image1 = PromotionDetails?.proImage?.dropFirst(3)
        if image1?.count == 0 {
            promotionImage.image = UIImage(named: "ic_default_img")
        }else{
            promotionImage.kf.setImage(with: URL(string: "\(PROMO_IMG1)\(image1 ?? "")"), placeholder: UIImage(named: "ic_default_img"))
        }
        descriptionDetails.text = PromotionDetails?.proLongDesc
        promotionInfo.text = PromotionDetails?.proShortDesc
    }
    
}
