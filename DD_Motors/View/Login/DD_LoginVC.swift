//
//  ViewController.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import UIKit
import SVPinView
import ImageSlideshow
import Toast_Swift
import Lottie
//import SDWebImage
class DD_LoginVC: BaseViewController,UITextFieldDelegate {

    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
   
    @IBOutlet weak var sendOTPBtn: GradientButton!
    @IBOutlet weak var enterOTPLbl: UILabel!
    @IBOutlet weak var mainviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerImage: ImageSlideshow!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var otpView: SVPinView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var resendButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    var enteredValues = ""
    var existencyValue = -1
    var receivedOTP = "0"
    var VM = DD_Login_VM()
    var VM1 = DD_TermsandconditionVM()
    private var loaderAnimationView : LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM1.VC1 = self
        self.VM.VC = self
        self.mobileNumberTF.delegate = self
        self.mobileNumberTF.keyboardType = .asciiCapableNumberPad
        self.loaderView.isHidden = true
//        self.playAnimation2()
     
        }
    override func viewWillAppear(_ animated: Bool) {
        tokendata()
        self.existencyValue = -1
        self.sendOTPBtn.setTitle("Send OTP", for: .normal)
        self.mobileNumberTF.text = ""
        self.enteredValues = ""
        self.mainviewHeightConstraint.constant = 200
        self.enterOTPLbl.isHidden = true
        self.stackView.isHidden = true
        self.otpView.isHidden = true
        self.otpView.clearPin()
        self.otpView.didFinishCallback = { [weak self] pin in
            print("The pin entered is \(pin)")
            self!.enteredValues = pin
            print(pin)
            }
    }
    

    @IBAction func mobileNumberEditingDidEnd(_ sender: Any) {
//        if self.mobileNumberTF.text!.count == 0{
//            self.view.makeToast("Enter mobile number", duration: 2.0, position: .center)
//        }else if self.mobileNumberTF.text!.count != 10{
//            self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .center)
//        }else{
//            let parameterJSON = [
//                    "ActionType": "57",
//                    "Location": [
//                        "UserName": "\(self.mobileNumberTF.text ?? "")"
//                        ]
//            ] as [String:Any]
//            print(parameterJSON)
//            self.VM.verifyMobileNumberAPI(paramters: parameterJSON)
        //}
        
    }
    @IBAction func resendBtn(_ sender: Any) {
        if self.mobileNumberTF.text!.count == 0{
            self.view.makeToast("Enter mobile number", duration: 2.0, position: .center)
        }else if self.mobileNumberTF.text!.count != 10{
            self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .center)
        }else{
            self.VM.sendOTP(mobileNumber: self.mobileNumberTF.text!, userName: "")
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if self.sendOTPBtn.currentTitle == "Send OTP"{
            if self.mobileNumberTF.text!.count == 0{
                self.view.makeToast("Enter mobile number", duration: 2.0, position: .center)
            }else if self.mobileNumberTF.text!.count != 10{
                self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .center)
            }else{
                self.VM.sendOTP(mobileNumber: self.mobileNumberTF.text!, userName: "")
            }
            
        }else{
            if self.enteredValues == ""{
                self.view.makeToast("Enter OTP", duration: 2.0, position: .center)
            }else if "123456" == self.enteredValues{
                let parameterJSON = [
                        "ActionType": "57",
                        "Location": [
                            "UserName": "\(self.mobileNumberTF.text ?? "")"
                            ]
                ] as [String:Any]
                print(parameterJSON)
                self.VM.verifyMobileNumberAPI(paramters: parameterJSON)
            }else{
                self.view.makeToast("Invalid OTP", duration: 2.0, position: .center)
            }
            
        }
        
    }
    func tokendata(){
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
        }else{
            let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!
            
            let url = URL(string: tokenURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            do {
                request.httpBody = parameters
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                    print(parseddata.access_token ?? "")
                    UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
        }
    }
        func playAnimation2(){
               loaderAnimationView = .init(name: "loader")
               loaderAnimationView!.frame = loaderAnimation.bounds
                 // 3. Set animation content mode
               loaderAnimationView!.contentMode = .scaleAspectFill
                 // 4. Set animation loop mode
               loaderAnimationView!.loopMode = .loop
                 // 5. Adjust animation speed
               loaderAnimationView!.animationSpeed = 0.5
               loaderAnimation.addSubview(loaderAnimationView!)
                 // 6. Play animation
               loaderAnimationView!.play()
           }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = (self.mobileNumberTF.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}

