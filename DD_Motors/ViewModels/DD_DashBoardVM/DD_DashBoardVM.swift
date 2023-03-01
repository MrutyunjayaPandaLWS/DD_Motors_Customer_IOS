//
//  DD_DashBoardVM.swift
//  DD_Motors
//
//  Created by ADMIN on 27/12/2022.
//

import UIKit
import Toast_Swift
import Alamofire
import ImageSlideshow


class DD_DashBoardVM {
    
    weak var VC: DD_DashboardVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var parameters = [String: Any]()
    var vehicleListArray = [LstUserVehicleDetails]()
    var sourceArray = [AlamofireSource]()
    var bannerImagesArray = [ObjImageGalleryList1]()
    func dashBoardApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.requestAPIs.dashBoardApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                    let dashboarMyVehicleDetails = result?.objImageGalleryList ?? ""
                    if dashboarMyVehicleDetails.count == 0{
                        
                       // self.VC?.emptyBannerImage.isHidden = false
                    }else{
                        //self.VC?.emptyBannerImage.isHidden = true
                        
                    }
                    
                   let dashboardDetails = result?.objCustomerDashboardList ?? []
                    if dashboardDetails.count != 0 {
                        UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].memberSince, forKey: "MemberSince")
                                print(result?.objCustomerDashboardList?[0].memberSince ?? "", "Membersince")
                                print(result?.objCustomerDashboardList?[0].notificationCount ?? "", "NotificationCount")
                                print(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? "", "totalpoints")
//                                self.VC?.totalPts.text = "\(result?.objCustomerDashboardList?[0].overAllPoints ?? 0)"
//                                self.VC?.redeemablePts.text = "\(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)"
//                                self.VC?.myPlumberPointsLbl.text = "\(result?.objCustomerDashboardList?[0].totalMappedPlumbers ?? 0)"
//                                self.VC?.myCSMPointsLbl.text = "\(result?.objCustomerDashboardList?[0].totalMappedCSM ?? 0)"
//                                self.VC?.totalSubDealerCountLbl.text = "\(result?.objCustomerDashboardList?[0].totalMappedSubDealers ?? 0)"
                                UserDefaults.standard.setValue(result?.objCustomerDashboardList?[0].redeemablePointsBalance ?? "", forKey: "TotalPoints")
                                UserDefaults.standard.synchronize()
                               
                                
                            }
                        let customerFeedbakcJSON = result?.lstCustomerFeedBackJsonApi ?? []
                        if customerFeedbakcJSON.count != 0 {
                            if result?.lstCustomerFeedBackJsonApi?[0].customerStatus ?? 0 != 1{
                                DispatchQueue.main.async{
//                                   let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HR_PopUpVC") as? HR_PopUpVC
//                                   vc!.delegate = self
//                                   vc!.titleInfo = ""
//                                    vc!.isComeFrom = "DeactivateAccount"
//                                    vc!.descriptionInfo = "Your account is deactivated please check with the administrator"
//                                   vc!.modalPresentationStyle = .overCurrentContext
//                                   vc!.modalTransitionStyle = .crossDissolve
//                                    self.VC?.present(vc!, animated: true, completion: nil)
                                }
                            }else{
                                
//                                @IBOutlet weak var profileImage: UIImageView!
                                let profileImg = String(result?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "").dropFirst(2)
                                print("\(PROMO_IMG1)\(profileImg), ProfilImage")
                                
                                self.VC!.profileImage.kf.setImage(with: URL(string: "\(PROMO_IMG1)\(profileImg)"), placeholder: UIImage(named: "ic_default_img"))
                                
                                UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].firstName, forKey: "FirstName")
                                self.VC?.userNameLbl.text = "\(result?.lstCustomerFeedBackJsonApi?[0].firstName ?? "")"
                                
                                var myString:NSString = "Membership ID  \(result?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? "")" as NSString
                                var myMutableString = NSMutableAttributedString()
                                myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Apple SD Gothic Neo SemiBold", size: 13.0)!])
                                myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location:0,length:14))
                                    // set label Attribute
                                self.VC?.memberShipIdLbl.attributedText = myMutableString
                                
                                
                                UserDefaults.standard.setValue(result?.lstCustomerFeedBackJsonApi?[0].loyaltyId, forKey: "LoyaltyId")
                                
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantEmail ?? "", forKey: "MerchantEmail")
                                print(result?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? "")

                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? "4", forKey: "verificationStatus")

                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerMobile ?? "", forKey: "Mobile")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].firstName ?? "", forKey: "FirstName")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].lastName ?? "", forKey: "LastName")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerEmail ?? "", forKey: "CustomerEmail")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].merchantId ?? "", forKey: "MerchantID")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].referralCode ?? "", forKey: "ReferralCode")
                                UserDefaults.standard.set(result?.lstCustomerFeedBackJsonApi?[0].customerId ?? "", forKey: "CustomerId")
                                
                                UserDefaults.standard.synchronize()
                               // self.notificationListingApi()
                              //  self.VC?.userNameLbl.text = result?.lstCustomerFeedBackJsonApi?[0].firstName ?? "-"
                            }
                            
                        }
                    self.VC?.dashboardVehicleListApi()

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
    func dashBoardApiVehicleApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.requestAPIs.dashBoardVehicleListAPi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        self.vehicleListArray = result?.lstUserVehicleDetails ?? []
                        print(self.vehicleListArray.count)
                        if self.vehicleListArray.count == 0{
                            self.VC?.emptyVehicleAnimation.isHidden = false
                            self.VC?.playAnimation()
                            self.VC?.vehicleView.isHidden = true
                            self.VC?.myVehicelLbl.isHidden = true
                            self.VC?.watchSpaceLbl.isHidden = false
                          //  self.VC?.emptyBannerImage.isHidden = false
                        }else{
                            self.VC?.emptyVehicleAnimation.isHidden = true
                            self.VC?.vehicleView.isHidden = false
                            self.VC?.myVehicelLbl.isHidden = false
                            self.VC?.watchSpaceLbl.isHidden = true
                            //self.VC?.emptyBannerImage.isHidden = true
                            self.VC?.myVehicleCollectionView.reloadData()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                    self.VC?.stopLoading()
                        self.VC?.emptyVehicleAnimation.isHidden = false
                        self.VC?.playAnimation()
                        self.VC?.vehicleView.isHidden = true
                        self.VC?.myVehicelLbl.isHidden = true
                        self.VC?.watchSpaceLbl.isHidden = false
                        self.VC?.loaderView.isHidden = true
                    }
                }
            }else{
                DispatchQueue.main.async {
                self.VC?.stopLoading()
                    self.VC?.emptyVehicleAnimation.isHidden = false
                    self.VC?.playAnimation()
                    self.VC?.vehicleView.isHidden = true
                    self.VC?.myVehicelLbl.isHidden = true
                    self.VC?.watchSpaceLbl.isHidden = false
                    self.VC?.loaderView.isHidden = true
                }
            }
        }
    }
 
    }
