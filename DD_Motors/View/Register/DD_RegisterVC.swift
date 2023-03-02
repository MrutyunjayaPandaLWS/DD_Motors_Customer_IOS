//
//  DD_RegisterVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import UIKit
import Toast_Swift
import Lottie

class DD_RegisterVC: BaseViewController, SelectedItemDelegate{
    func subscriptionDidTap(_ vc: DD_DropDownVC) {}
    
    func helpTopicDidTap(_ vc: DD_DropDownVC) {}
    
    func stateDidTap(_ vc: DD_DropDownVC) {
        self.selectedStateId = vc.selectedStateId
        self.stateLbl.text = vc.selectedStateName
        self.selectedCityId = -1
        self.cityLbl.text = "Select City"
        
    }
    
    func cityDidTap(_ vc: DD_DropDownVC) {
        self.selectedCityId = vc.selectedCityId
        self.cityLbl.text = vc.selectedCityName
       
    }
    

    @IBOutlet weak var vehicleTF: UITextField!
    
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    
    var selectedStateId = -1
    var selectedCityId = -1
    var enteredMobileNumber = 0
    var VM = DD_RegistrationVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(goBackToLogin), name: Notification.Name.goToLogin, object: nil)
    }
    
    @objc func goBackToLogin(){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func backToLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func stateBTN(_ sender: Any) {
       
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DropDownVC") as! DD_DropDownVC
        vc.delegate = self
        vc.itsFrom = "STATE"
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    @IBAction func cityBtn(_ sender: Any) {
        
        if self.selectedStateId == -1{
            self.view.makeToast("Select State", duration: 2.0, position: .center)
            
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DropDownVC") as! DD_DropDownVC
            vc.itsFrom = "CITY"
            vc.delegate = self
            vc.selectedStateId = self.selectedStateId
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        if self.vehicleTF.text?.count == 0{
            self.view.makeToast("Enter vehicle number", duration: 2.0, position: .center)
        }else if nameTF.text!.count == 0 {
            self.view.makeToast("Enter name", duration: 2.0, position: .center)
        }else if stateLbl.text ?? "" == "Select State" {
            self.view.makeToast("Select State", duration: 2.0, position: .center)
        }else if cityLbl.text ?? "" == "Select City" {
            self.view.makeToast("Select City", duration: 2.0, position: .center)
        }else{
            let parameter = [
                "ActionType": "0",
                "ObjCustomerJson": [
                    "FirstName": "\(self.nameTF.text ?? "")",
                    "MerchantId":"1",
                    "StateId": "\(self.selectedStateId)",
                    "CityId": "\(self.selectedCityId)",
                    "IsActive":"1",
                    "LoyaltyId": "\(self.enteredMobileNumber)",
                    "Mobile": "\(self.enteredMobileNumber)",
                    "VehicleNumber": "\(self.vehicleTF.text ?? "")"
                    ]
            ] as [String: Any]
            print(parameter)
            self.VM.registrationSubmissionApi(parameter: parameter)
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

}
