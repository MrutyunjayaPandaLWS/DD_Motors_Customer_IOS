//
//  File.swift
//  DD_Motors
//
//  Created by Arokia-M3 on 26/12/22.
//

import Foundation
import Toast_Swift

class DD_Login_VM {
    
    weak var VC: DD_LoginVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var count = 0
    var timer = Timer()
    var otpData = ""
    var parameters = [String: Any]()
    var userId = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var userFullName = UserDefaults.standard.string(forKey: "UserName") ?? ""
    var parameter: JSON?
    
    
    func verifyMobileNumberAPI(paramters: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
       print(pushID,"jdsd")
        let url = URL(string: checkUserExistencyURL)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: paramters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "TOKEN") ?? "")", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do{
                let str = String(decoding: data, as: UTF8.self) as String?
                 print(str, "- Mobile Number Exists")
                if str ?? "" != "1"{
                    DispatchQueue.main.async{
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
//                        self.VC?.view.makeToast("Mobile number is doesn't exists", duration: 2.0, position: .center)
//                        self.VC?.mobileNumberTF.text = ""
                        if self.VC?.existencyValue == -1{
                            self.VC?.existencyValue = 1
                            self.timer.invalidate()
                            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_RegisterVC") as! DD_RegisterVC
                            vc.enteredMobileNumber = Int(self.VC?.mobileNumberTF.text ?? "")!
                            self.VC!.navigationController?.pushViewController(vc, animated: true)

                        }
                    }
                }else{
                    DispatchQueue.main.async{
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        if self.VC?.existencyValue == -1{
                            self.VC?.existencyValue = 1
                            self.timer.invalidate()
                            self.loginSubmissionApi(username: self.VC?.mobileNumberTF.text ?? "")
                        }
                    }
                }
                 }catch{
                     self.VC?.stopLoading()
                     self.VC?.loaderView.isHidden = true
                     print("parsing Error")
            }
        })
        task.resume()
    }
    
    func sendOTP(mobileNumber : String, userName : String){
        DispatchQueue.main.async {
            let parameterJSON = [
                "UserName": userName,
                "UserId": -1,
                "MobileNo": mobileNumber,
                "OTPType": "Enrollment",
                "MerchantUserName": "DDMotorsDemoAdmin"
            ] as [String: Any]
            print(parameterJSON)
            self.otpRequestAPI(parameters: parameterJSON)
            self.VC?.enteredValues = ""
            self.timer.invalidate()
            self.VC?.timerLbl.text = "00:59"
            self.VC?.mainviewHeightConstraint.constant = 280
            self.VC?.enterOTPLbl.isHidden = false
            self.VC?.stackView.isHidden = false
            self.VC?.otpView.isHidden = false
            self.VC?.resendButton.isHidden = true
            self.VC?.sendOTPBtn.setTitle("Submit", for: .normal)
            self.count = 60
            self.VC?.otpView.isHidden = false
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            }
    
    }
    @objc func update() {
        if(self.count > 1) {
            self.count = Int(self.count) - 1
            self.VC?.timerLbl.text = "00:\(self.count)"
            self.VC?.resendButton.isHidden = true
           
        }else{
            self.timer.invalidate()
            self.VC?.timerLbl.text = "00:00"
            self.VC?.resendButton.isHidden = false
            self.VC?.sendOTPBtn.setTitle("Send OTP", for: .normal)
            self.VC?.otpView.clearPin()
        }
    }
    
    func otpRequestAPI(parameters: JSON){
        self.VC?.startLoading()
        self.VC?.playAnimation2()
        self.VC?.loaderView.isHidden = false
        self.requestAPIs.getloginOTP_API(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    let response = result?.returnMessage ?? ""
                    print("Login OTP - ", response)
                    self.VC?.receivedOTP = response
                  //  self.VC?.sendOTPBtn.setTitle("Submit", for: .normal)
                    DispatchQueue.main.async {
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
    func loginSubmissionApi(username: String){
        self.VC?.startLoading()
        self.VC?.playAnimation2()
        self.VC?.loaderView.isHidden = false
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
                                self.VC?.loaderView.isHidden = true
                                self.VC?.view.makeToast("Your account is deleted.", duration: 2.0, position: .center)
                                
                                self.VC?.stopLoading()
                            }
                            return
                        } else {
                            if result?.userList?[0].verifiedStatus ?? 0 == 1 || result?.userList?[0].verifiedStatus ?? 0 != 4{
                                    DispatchQueue.main.async{
                                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_TermsandconditionVC") as! DD_TermsandconditionVC
                                        vc.username = self.VC?.mobileNumberTF.text ?? ""
                                        self.VC!.navigationController?.pushViewController(vc, animated: true)
                                        self.VC?.loaderView.isHidden = true
                                        self.VC?.stopLoading()
                                    }
                                    return
                            }else if result?.userList?[0].verifiedStatus ?? 0 == 4{
                                DispatchQueue.main.async{
                                    self.VC?.view.makeToast("Your account has been unverified. Kindly contact administrator", duration: 2.0, position: .center)
                                    self.VC?.existencyValue = -1
                                    self.VC?.sendOTPBtn.setTitle("Send OTP", for: .normal)
                                    self.VC?.mobileNumberTF.text = ""
                                    self.VC?.enteredValues = ""
                                    self.VC?.mainviewHeightConstraint.constant = 200
                                    self.VC?.enterOTPLbl.isHidden = true
                                    self.VC?.stackView.isHidden = true
                                    self.VC?.otpView.isHidden = true
                                    self.VC?.otpView.clearPin()
                                    self.VC?.loaderView.isHidden = true
                                    self.VC?.stopLoading()
                                }
                            }
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
