//
//  DD_SubscriptionDropDownVM.swift
//  DD_Motors
//
//  Created by ADMIN on 11/01/2023.
//

import Foundation
import Toast_Swift

class DD_SubscriptionDropDownVM {
    
    weak var VC: DD_SubscriptionVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    func subscriptionSubmission(parameter: JSON){
        self.requestAPIs.SubscriptionSubmission(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        let response = String(result?.returnMessage ?? "").dropFirst(1)
                        print(response, "asdfhjasdhfasdhjfasdf")
                        print(self.VC!.loyaltyId)
                        if response != "-1" {
                            if "\(response)" == self.VC!.loyaltyId{
                                self.VC!.selectedTitle = ""
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscriptionSuccessPopUp") as! DD_SubscriptionSuccessPopUp
                                vc.modalTransitionStyle = .coverVertical
                                vc.modalPresentationStyle = .overFullScreen
                                self.VC!.present(vc, animated: true)
//                                self.VC!.view.makeToast("Subscription Submission Success", duration: 2.0, position:  .bottom)
//                                self.VC!.bookingIdImg.image = UIImage(named: "selected")
//                                self.VC!.yourVINImg.image = UIImage(named: "Ellipse 105")
//                                self.VC!.selectYourVRN.image = UIImage(named: "Ellipse 105")
//                                self.VC!.selectedStatusId = 1
//                                self.VC!.selectedSourceId = 1
//                                self.VC!.offlineSubscriptionView.backgroundColor = .white
//                                self.VC!.onlineSubscriptionView.backgroundColor = .white
                        }else{
                            self.VC!.view.makeToast("Something went wrong. Please try again late!", duration: 2.0, position:  .bottom)
                            self.VC!.bookingIdImg.image = UIImage(named: "selected")
                            self.VC!.yourVINImg.image = UIImage(named: "Ellipse 105")
                            self.VC!.selectYourVRN.image = UIImage(named: "Ellipse 105")
                            self.VC!.selectedStatusId = 1
                            self.VC!.selectedSourceId = 1
                            self.VC!.offlineSubscriptionView.backgroundColor = .white
                            self.VC!.onlineSubscriptionView.backgroundColor = .white
                        }
                        }else{
                            self.VC!.view.makeToast("Submission Failed" , duration: 2.0, position:  .bottom)
                            self.VC!.bookingIdImg.image = UIImage(named: "selected")
                            self.VC!.yourVINImg.image = UIImage(named: "Ellipse 105")
                            self.VC!.selectYourVRN.image = UIImage(named: "Ellipse 105")
                            self.VC!.selectedStatusId = 1
                            self.VC!.selectedSourceId = 1
                            self.VC!.offlineSubscriptionView.backgroundColor = .white
                            self.VC!.onlineSubscriptionView.backgroundColor = .white
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
