//
//  DD_TermsandconditionVM.swift
//  DD_Motors
//
//  Created by ADMIN on 27/12/2022.
//

import UIKit
import Toast_Swift

class DD_TermsandconditionVM {
    
    weak var VC: DD_TermsandconditionVC?
    weak var VC1: DD_LoginVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var parameters = [String: Any]()
    
    func loginSubmissionApi(username: String){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        let parameter = [
            "UserName": username,
            "Password":"123456",
            "UserActionType": "GetPasswordDetails",
            "Browser": "IOS",
            "LoggedDeviceName": "IOS",
            "UserType": "Customer",
            "PushID":""
        ] as [String: Any]
        print(parameter)
        self.requestAPIs.loginApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.userList?[0].result ?? 0)
                        if result?.userList?[0].isDelete ?? 0 == 1 {
                            DispatchQueue.main.async{
                                self.VC?.view.makeToast("Your account is deleted.", duration: 2.0, position: .center)
                                self.VC?.stopLoading()
                                self.VC?.loaderView.isHidden = true
                            }
                            return
                        } else {
                            if result?.userList?[0].result ?? 0 == 1 {
                                    DispatchQueue.main.async {
                                        UserDefaults.standard.set(password, forKey: "SavedPassword")
                                        UserDefaults.standard.set(result?.userList?[0].userType ?? -1, forKey: "userType")
                                        UserDefaults.standard.set(result?.userList?[0].userId ?? -1, forKey: "UserID")
                                        UserDefaults.standard.set(result?.userList?[0].userName ?? "", forKey: "UserName")
                                        UserDefaults.standard.set(result?.userList?[0].custAccountNumber ?? "", forKey: "custAccountNumber")
                                        UserDefaults.standard.set(result?.userList?[0].mobile ?? "", forKey: "customerMobile")
                                        UserDefaults.standard.set(result?.userList?[0].merchantMobileNo ?? "", forKey: "MerchantMobile")
                                        UserDefaults.standard.set(result?.userList?[0].merchantEmailID ?? "", forKey: "MerchantEmailId")
                                        UserDefaults.standard.set(result?.userList?[0].customerTypeID ?? -1, forKey: "CustomerTypeId")
                                        UserDefaults.standard.set(result?.userList?[0].isUserActive ?? -1, forKey: "IsUserActive")
                                        UserDefaults.standard.set(result?.userList?[0].name ?? "", forKey: "CustomerName")
                                        
                                        UserDefaults.standard.setValue(true, forKey: "IsloggedIn?")
                                        
                                        DispatchQueue.main.async {
                                            if #available(iOS 13.0, *) {
                                                let sceneDelegate = self.VC!.view.window!.windowScene!.delegate as! SceneDelegate
                                                sceneDelegate.setHomeAsRootViewController()
                                            } else {
                                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                appDelegate.setHomeAsRootViewController()
                                            }
                                            self.VC?.stopLoading()
                                            self.VC?.loaderView.isHidden = true
                                        }
                                    }
                                }else if result?.userList?[0].verifiedStatus ?? 0 != 1{
                                    DispatchQueue.main.async{
                                        self.VC?.view.makeToast("Password is Invalid", duration: 2.0, position: .center)
                                        self.VC?.stopLoading()
                                        self.VC?.loaderView.isHidden = true
                                    }
                                    return
                                
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    self.VC?.loaderView.isHidden = true
                }
            }
        }
    }
    
}
