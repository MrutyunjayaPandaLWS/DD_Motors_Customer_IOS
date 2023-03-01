//
//  DD_SideMenuVM.swift
//  DD_Motors
//
//  Created by ADMIN on 28/12/2022.
//

import UIKit
import Kingfisher
class DD_SideMenuVM{
    
    weak var VC: DD_SidemenuVC?
    var requestAPIs = RestAPI_Requests()
    
    func myProfileApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.requestAPIs.dashBoardApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    self.VC?.loaderView.isHidden = true
                        let customerFeedbakcJSON = result?.lstCustomerFeedBackJsonApi ?? []
                        if customerFeedbakcJSON.count != 0 {
                                self.VC?.membershipIdLbl.text = "Membership ID \(result?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? "")"
                                self.VC?.userNameLbl.text = "\(result?.lstCustomerFeedBackJsonApi?[0].firstName ?? "")"
                            self.VC?.profileName = "\(result?.lstCustomerFeedBackJsonApi?[0].firstName ?? "")"
                            self.VC?.mobileNumber = "\(result?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? "")"
                            self.VC?.location = "\(result?.lstCustomerFeedBackJsonApi?[0].cityName ?? "")"
                            let profileImg = String(result?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "").dropFirst(2)
                            print("\(PROMO_IMG1)\(profileImg), ProfilImage")
                            if profileImg.count != 0{
                                self.VC?.profileImageURL = "\(PROMO_IMG1)\(profileImg)"
                                //self.VC?.userImage.kf.setBackgroundImage(with: URL(string: "\(PROMO_IMG1)\(profileImg)"), for: .normal)
                                
                                
                                let profileImg = String(result?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "").dropFirst(2)
                                print("\(PROMO_IMG1)\(profileImg), ProfilImage")
                                
                                self.VC!.userImage.kf.setImage(with: URL(string: "\(PROMO_IMG1)\(profileImg)"), placeholder: UIImage(named: "ic_default_img"))
                                
                            }else{
                                self.VC?.userImage.image = UIImage(named: "ic_default_img")
                            }

                            
//                            self.VC!.profileImage.kf.setImage(with: ), placeholder: UIImage(named: "ic_default_img"))
                            
                        }
               
                    
                }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                self.VC?.stopLoading()
                }
            }
        }
    }
    
}
