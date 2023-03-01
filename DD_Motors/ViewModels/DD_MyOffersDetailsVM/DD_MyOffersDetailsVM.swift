//
//  DD_MyOffersDetailsVM.swift
//  DD_Motors
//
//  Created by ADMIN on 21/01/2023.
//

import Foundation
import Toast_Swift

class DD_MyOffersDetailsVM {
    
    weak var VC: DD_MyOffersDetailsVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var myOffersListArray = [LstGiftCardType1]()
    func myOffersListApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.myOffersListArray.removeAll()
        self.requestAPIs.myOffersDetailsApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        
                        self.myOffersListArray =  result?.lstGiftCardType ?? []
                        if self.myOffersListArray.count != 0 {
                            self.VC?.offersTitleLbl.text = self.myOffersListArray[0].giftCardTypeName ?? ""
                            self.VC?.offerIdTF.text = self.myOffersListArray[0].cardNumber ?? ""
                            let filterDate = String(self.myOffersListArray[0].expiryDate ?? "").split(separator: "T")
                            if filterDate.count != 0 {
                                self.VC?.offersValidTill.text = "\(filterDate[0])"
                            }else{
                                self.VC?.offersValidTill.text = self.myOffersListArray[0].expiryDate ?? ""
                            }
                            
                            if self.VC?.itsFrom == "Description"{
                                self.VC?.desc = self.myOffersListArray[0].message ?? ""
                                self.VC?.loadHTMLStringImage(htmlString: self.VC?.desc ?? "")
                                
                            }else if self.VC?.itsFrom == "TC"{
                                self.VC?.termsandcondition = self.myOffersListArray[0].termsAndConditions ?? ""
                                self.VC?.loadHTMLStringImage(htmlString: self.VC?.termsandcondition ?? "")
                            }else if self.VC?.itsFrom == "Use"{
                                self.VC?.howToUse = self.myOffersListArray[0].instruction ?? ""
                                self.VC?.loadHTMLStringImage(htmlString: self.VC?.howToUse ?? "")
                                
                            }
                          if self.myOffersListArray[0].expiry ?? 0 == 0{
                              self.VC?.redeemButton.isHidden = false
                          }else{
                              self.VC?.redeemButton.isHidden = true
                          }
                        }
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                      
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
