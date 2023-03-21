//
//  DD_PaymentVM.swift
//  DD_Motors
//
//  Created by ADMIN on 21/03/2023.
//

import Foundation
import Toast_Swift

class DD_PaymentVM {
    
    weak var VC: DD_PaymentVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    func subscriptionSubmission(parameter: JSON){
        self.requestAPIs.SubscriptionSubmission(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
//                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        let response = String(result?.returnMessage ?? "").dropFirst(1)
                        print(response, "asdfhjasdhfasdhjfasdf")
                        if response != "-1" {
                            if "\(response)" == self.VC!.loyaltyId{
                                self.VC!.selectedTitle = ""
                                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscriptionSubmissionPopUpVC") as! DD_SubscriptionSubmissionPopUpVC
                                vc.payMentId = self.VC!.orderID
                                self.VC!.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            self.VC!.view.makeToast("Something went wrong. Please try again late!", duration: 2.0, position:  .bottom)
                        }
                        }else{
                            self.VC!.view.makeToast("Submission Failed" , duration: 2.0, position:  .bottom)
                        }
                    }
                }else{
                    DispatchQueue.main.async {
//                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
//                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
            }
        }
    }
}

