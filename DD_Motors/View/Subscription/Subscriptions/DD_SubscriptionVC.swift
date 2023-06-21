//
//  DD_SubscriptionVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import UIKit
import Toast_Swift
import Lottie
class DD_SubscriptionVC: BaseViewController, SelectedItemDelegate, SendBackDetails{
    func paymentFailed(_ vc: DD_PaymentVC) {
        self.bookingIdImg.image = UIImage(named: "Ellipse 105")
        self.yourVINImg.image = UIImage(named: "Ellipse 105")
        self.selectYourVRN.image = UIImage(named: "Ellipse 105")
        self.onlineSubscriptionImage.image = UIImage(named: "Ellipse 105")
        self.offlineSubscriptionImage.image = UIImage(named: "Ellipse 105")
        self.offlineSubscriptionView.backgroundColor = .white
        self.onlineSubscriptionView.backgroundColor = .white
        self.selectedStatusId = -1
        self.selectedTitle = ""
        self.selectedSourceId = -1
    }
    
    func subscriptionDidTap(_ vc: DD_DropDownVC) {
        self.selectedDealerTitle.text = vc.subscriptionTitle
        self.selectedTitle = vc.subscriptionTitle
        self.subscriptionStatusId = vc.subscriptionStatusId
    }
    
    func stateDidTap(_ vc: DD_DropDownVC) {}
    
    func cityDidTap(_ vc: DD_DropDownVC) {}
    
    func helpTopicDidTap(_ vc: DD_DropDownVC) {}
    

    @IBOutlet weak var selectedDealerTitle: UILabel!
    @IBOutlet weak var amountLbl: UITextField!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var bookingIdImg: UIImageView!
    
    @IBOutlet weak var yourVINImg: UIImageView!
    
    @IBOutlet weak var selectYourVRN: UIImageView!
    
    @IBOutlet weak var onlineSubscriptionView: UIView!
    
    @IBOutlet weak var offlineSubscriptionView: UIView!
    
    @IBOutlet weak var onlineSubscriptionImage: UIImageView!
    
    @IBOutlet weak var offlineSubscriptionImage: UIImageView!
    
  
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    
    @IBOutlet var comingSoonScreen: UIView!
    
    var selectedStatusId = -1
   var subscriptionStatusId = -1
    var selectedTitle = ""
    var selectedSourceId = -1
    var VM = DD_SubscriptionDropDownVM()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var itsFrom = ""
    var amount = "885"
    override func viewDidLoad() {
        super.viewDidLoad()
            self.VM.VC = self
            self.amountLbl.isEnabled = false
            //        self.selectedStatusId = 1
            subView.clipsToBounds = false
            subView.layer.cornerRadius = 36
            comingSoonScreen.isHidden = true
            subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.bookingIdImg.image = UIImage(named: "Ellipse 105")
            self.yourVINImg.image = UIImage(named: "Ellipse 105")
            self.selectYourVRN.image = UIImage(named: "Ellipse 105")
            self.onlineSubscriptionImage.image = UIImage(named: "Ellipse 105")
            self.offlineSubscriptionImage.image = UIImage(named: "Ellipse 105")
            self.offlineSubscriptionView.backgroundColor = .white
            self.onlineSubscriptionView.backgroundColor = .white
            self.loaderView.isHidden = true
            if self.itsFrom == "SideMenu"{
                self.backButton.isHidden = false
            }else{
                self.backButton.isHidden = true
            }
            NotificationCenter.default.addObserver(self, selector: #selector(goToDashBoard), name: Notification.Name.goToDashBoard, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(goToDealerlocation), name: Notification.Name.goToDealerlocation, object: nil)
        
    }
    @objc func goToDashBoard(){
        if self.itsFrom == "SideMenu"{
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            tabBarController?.selectedIndex = 0
        }
    }
    @objc func goToDealerlocation(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DealershipLocationVC") as! DD_DealershipLocationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
                self.comingSoonScreen.isHidden = true
            }
        }else{
            self.selectedDealerTitle.text = "Select Type"
        }
    }

    @IBAction func selectYourBookingId(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.bookingIdImg.image = UIImage(named: "selected")
            self.yourVINImg.image = UIImage(named: "Ellipse 105")
            self.selectYourVRN.image = UIImage(named: "Ellipse 105")
            self.selectedStatusId = 1
            self.selectedDealerTitle.text = "Select"
        }
    }
    @IBAction func selectYourVIN(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.yourVINImg.image = UIImage(named: "selected")
            self.bookingIdImg.image = UIImage(named: "Ellipse 105")
            self.selectYourVRN.image = UIImage(named: "Ellipse 105")
            self.selectedStatusId = 2
            self.selectedDealerTitle.text = "Select"
        }
    }
    @IBAction func selectYourVRNButton(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.selectYourVRN.image = UIImage(named: "selected")
            self.yourVINImg.image = UIImage(named: "Ellipse 105")
            self.bookingIdImg.image = UIImage(named: "Ellipse 105")
            self.selectedStatusId = 3
            self.selectedDealerTitle.text = "Select"
        }
    }
    
    @IBAction func selectCategoryBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            if self.selectedStatusId != -1{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DropDownVC") as! DD_DropDownVC
                vc.delegate = self
                vc.itsFrom = "SUBSCRIPTION"
                vc.selectedStatusId = self.selectedStatusId
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }else{
                self.view.makeToast("Select Type", duration: 2.0, position: .bottom)
            }
        }
    }
    
    @IBAction func onlineSubscriptionBnt(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.selectedSourceId = 2
            self.onlineSubscriptionImage.image = UIImage(named: "selected")
            self.offlineSubscriptionImage.image = UIImage(named: "Ellipse 105")
            self.onlineSubscriptionView.backgroundColor = #colorLiteral(red: 0.9523764253, green: 0.9772849679, blue: 0.9983460307, alpha: 1)
            self.offlineSubscriptionView.backgroundColor = .white
        }
    }
    
    @IBAction func offlineSubscriptionBnt(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.selectedSourceId = 1
            self.offlineSubscriptionImage.image = UIImage(named: "selected")
            self.onlineSubscriptionImage.image = UIImage(named: "Ellipse 105")
            self.offlineSubscriptionView.backgroundColor = #colorLiteral(red: 0.9523764253, green: 0.9772849679, blue: 0.9983460307, alpha: 1)
            self.onlineSubscriptionView.backgroundColor = .white
        }
    }
    @IBAction func proceedbtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            if self.selectedStatusId == -1 {
                self.view.makeToast("Select Type", duration: 2.0, position: .bottom)
            }else if self.selectedTitle == ""{
                self.view.makeToast("Select Subscription type", duration: 2.0, position: .bottom)
            }else if self.subscriptionStatusId == 0{
                //            if selectedSourceId = 1{
                //                self.view.makeToast("Your subscription is in pending!", duration: 2.0, position: .bottom)
                //            }else{
                //                self.paymentProceedApi()
                //            }
                self.view.makeToast("Your subscription is in pending!", duration: 2.0, position: .bottom)
                
            }else if self.subscriptionStatusId == 1{
                self.view.makeToast("You have already subscribed!", duration: 2.0, position: .bottom)
            }else if self.selectedSourceId == -1{
                self.view.makeToast("Select Mode", duration: 2.0, position: .bottom)
            }else{
                self.startLoading()
                self.loaderView.isHidden = false
                self.playAnimation2()
                if self.selectedSourceId == 1{
                    let parameter = [
                        "ActionType": "1",
                        "ActorId": "\(self.userID)",
                        "Amount": "885",
                        "LoyaltY_ID": "\(UserDefaults.standard.string(forKey: "LoyaltyId") ?? "")",
                        "SourceId": "\(self.selectedStatusId)", // 1-->>BookingID,2-->>VIN, 3-->>VRN
                        "SourceType": "3",// 1-->> Android, 3-->>IOS
                        "SourceValue": "\(self.selectedTitle)",
                        "SubscriptionTypeId":"\(self.selectedSourceId)",// 1-->> Offline, 2-->>Online
                        "SubscriptionStatus":"0",
                        "PaymentID":""
                        
                    ] as [String: Any]
                    print(parameter)
                    self.VM.subscriptionSubmission(parameter: parameter)
                }else{
                    self.comingSoonScreen.isHidden = false
                    //                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_ComingSoonVC") as! DD_ComingSoonVC
                    //                vc.modalTransitionStyle = .coverVertical
                    //                vc.modalPresentationStyle = .overFullScreen
                    //                self.present(vc, animated: true)
                    
                    //                self.paymentProceedApi()
                }
                
            }
        }
    }
    
    
    
    
    
    @IBAction func commingSoonCloseBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            dismiss(animated: true){
                self.comingSoonScreen.isHidden = true
                self.loaderView.isHidden = true
            }
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func myDescriptionbtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscriptionHistoryVC") as! DD_SubscriptionHistoryVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
    func getPostString(params:[String:Any]) -> String
        {
            var data = [String]()
            for(key, value) in params
            {
                data.append(key + "=\(value)")
            }
            print(data.map { String($0) }.joined(separator: "&"))
            return data.map { String($0) }.joined(separator: "&")
        }
    func paymentProceedApi(){
        let randomNumbers = Int(arc4random_uniform(1000000000))
        let orderId = "\(randomNumbers)".prefix(6)
        
        var request = URLRequest(url: URL(string: paymentGateWayURL)!)
        let parameters =  ["order_amount": self.amount,
                           "order_id": "ORD\(orderId)",
                           "order_currency": "INR",
                           "customer_details":[
                            "customer_id": "\(UserDefaults.standard.string(forKey: "CustomerId") ?? "")",
                            "customer_name": "\(UserDefaults.standard.string(forKey: "FirstName") ?? "")",
                            "customer_phone": "\(UserDefaults.standard.string(forKey: "Mobile") ?? "")"
                           ]] as [String : Any]
        print(parameters, "Parameter")
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(appId, forHTTPHeaderField: "x-client-id")
        request.setValue(secretKey, forHTTPHeaderField: "x-client-secret")
        request.setValue(appVersion, forHTTPHeaderField: "x-api-version")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                       return
                   }
                   request.httpBody = httpBody
                   request.timeoutInterval = 20
                   let session = URLSession.shared
                   session.dataTask(with: request) { (data, response, error) in
                       if let response = response {
                           print(response)
                       }
                       if let data = data {
                           do {
                               let json = try JSONSerialization.jsonObject(with: data, options: [])
                               print(json, " - Response JSON")
                               let parseddata = try JSONDecoder().decode(PaymentModel.self, from: data)
                               print(parseddata.payment_session_id ?? "" , "Payment Session ID")
                               print(parseddata.order_id ?? "" , "Order ID")
                               UserDefaults.standard.set(parseddata.payment_session_id ?? "", forKey: "PAYMENT_TOKEN")
                               UserDefaults.standard.set(parseddata.order_id ?? "", forKey: "ORDER_ID")
                               if parseddata.payment_session_id ?? "" != "" && parseddata.order_id ?? "" != ""{
                                   DispatchQueue.main.async {
                                       let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_PaymentVC") as! DD_PaymentVC
                                       vc.orderID = parseddata.order_id ?? ""
                                       vc.paymentToken = parseddata.payment_session_id ?? ""
                                       vc.itsFrom = "Main"
                                       vc.selectedStatusId = "\(self.selectedStatusId)"
                                       vc.selectedTitle = self.selectedTitle
                                       vc.selectedSourceId = "\(self.selectedSourceId)"
                                       self.navigationController?.pushViewController(vc, animated: true)
                                   }
                                   
                               }else{
                                   DispatchQueue.main.async {
                                       self.view.makeToast("Something went wrong! Try again later...", duration: 2.0, position: .bottom)
                                   }
                                   
                               }
                               DispatchQueue.main.async {
                                   self.loaderView.isHidden = true
                               }
                               
                           } catch {
                               DispatchQueue.main.async {
                                   print(error)
                                   self.loaderView.isHidden = true
                               }
                           }
                       }
                   }.resume()
        }
    
}
