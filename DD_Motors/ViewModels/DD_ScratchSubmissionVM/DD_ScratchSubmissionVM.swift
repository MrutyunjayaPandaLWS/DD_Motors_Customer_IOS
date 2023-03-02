//
//  DD_ScratchSubmissionVM.swift
//  DD_Motors
//
//  Created by ADMIN on 21/01/2023.
//

import Foundation
import Toast_Swift

class DD_ScratchSubmissionVM {
    
    weak var VC: DD_SuccessPopUp?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
  //  var serviceHistoryListingArray = [LstUserVehicleDetails1]()
    func scratchStatusApi(parameter: JSON){
        self.VC?.loaderView.isHidden = false
         self.VC?.playAnimation2()
        self.requestAPIs.scratchSubmissionApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        print(self.VC?.loyaltyId ?? "")
                        print(result?.returnMessage ?? "")
                        let responeValue = String(result?.returnMessage ?? "").split(separator: "~")
                        if responeValue.count != 0{
                            if "\(responeValue[0])" == self.VC?.loyaltyId{
                                self.VC?.scratchView.isHidden = true
                                self.VC?.congratulationView.isHidden = false
                                self.VC?.successAnimation.isHidden = false
                                self.VC?.playAnimation()
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                                    self.VC?.successAnimation.isHidden = true
                                    NotificationCenter.default.post(name: .hitMyOffersApi, object: nil)
                                })
                                
                                
                            }else{
                                self.VC?.view.makeToast("Something went wrong! Please try later", duration: 1.0, position: .bottom)
                                NotificationCenter.default.post(name: .hitMyOffersApi, object: nil)
                            }
                            
                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                }
            }
        }
    }
}
