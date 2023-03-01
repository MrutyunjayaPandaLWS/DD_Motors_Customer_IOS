//
//  DD_RegistrationVM.swift
//  DD_Motors
//
//  Created by ADMIN on 27/12/2022.
//

import UIKit
import Toast_Swift

class DD_RegistrationVM {
    
    weak var VC: DD_RegisterVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var parameters = [String: Any]()
    
    func registrationSubmissionApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()

        self.requestAPIs.registrationSubmissionApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        print(result?.returnMessage ?? "")
                        let returnMessage = "\(result?.returnMessage ?? "")".split(separator: "~")
                        if returnMessage.count != 0{
                            print(returnMessage[0])
                            if returnMessage[0] == "1"{
                                    self.VC?.view.makeToast("Registration Success", duration: 3.0, position: .center)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                                        self.VC?.navigationController?.popViewController(animated: true)
                                    })
                                }else{
                                    self.VC?.view.makeToast("Registration Failed", duration: 3.0, position: .center)
                                }
                        }else{
                            self.VC?.view.makeToast("Something went wrong! Try again later", duration: 3.0, position: .center)
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
