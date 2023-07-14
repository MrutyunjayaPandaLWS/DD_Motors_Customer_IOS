//
//  MyProfileVC.swift
//  DD_Motors
//
//  Created by Arokia-M3 on 24/12/22.
//

import UIKit
import Photos
import Toast_Swift
import Kingfisher
import Lottie
class DD_MyProfileVC: BaseViewController, SelectedItemDelegate, DateSelectedDelegate, UITextFieldDelegate{
    func subscriptionDidTap(_ vc: DD_DropDownVC) {}
    
    func acceptDate(_ vc: DD_DOBVC) {
        self.dobTF.text = vc.selectedDate
    }
    
    func declineDate(_ vc: DD_DOBVC) {}
    
    func helpTopicDidTap(_ vc: DD_DropDownVC) {}
    
    func stateDidTap(_ vc: DD_DropDownVC) {
        self.selectedStateId = vc.selectedStateId
        print(self.selectedStateId,"dljkdk")
        self.stateTF.text = vc.selectedStateName
        self.selectedCityId = -1
        self.cityTF.text = "Select City"
    }
    
    func cityDidTap(_ vc: DD_DropDownVC) {
        self.selectedCityId = vc.selectedCityId
        self.cityTF.text = vc.selectedCityName
    }
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var mobileNumberTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var stateTF: UITextField!
    @IBOutlet var cityTF: UITextField!
    @IBOutlet var pinCodeTF: UITextField!
    @IBOutlet var dobTF: UITextField!
    @IBOutlet var editOutBtn: GradientButton!
    @IBOutlet var profileNameLbl: UILabel!
    @IBOutlet var mobileNumberLbl: UILabel!
    @IBOutlet var locationLbl: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet weak var dobBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var stateButton: UIButton!
    
    @IBOutlet weak var subView: UIView!
    
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
   private var loaderAnimationView : LottieAnimationView?
    
    var VM = DD_MyProfileVM()
    let picker = UIImagePickerController()
    var strBase64 = ""
    var strdata1 = ""
    var profileName = ""
    var mobileNumber = ""
    var location = ""
    var profileImageURL = ""
    var fileType = ""
    var selectedStateId = -1
    var selectedCityId = -1
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let customerId = UserDefaults.standard.string(forKey: "CustomerId") ?? ""
    let merchantID = UserDefaults.standard.string(forKey: "MerchantID") ?? ""
    var addressID = ""
    var locationID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.VM.VC = self
            self.loaderView.isHidden = true
            self.mobileNumberTF.delegate = self
            self.pinCodeTF.delegate = self
            picker.delegate = self
            self.nameTF.isEnabled = false
            self.mobileNumberTF.isEnabled = false
            self.addressTF.isEnabled = false
            self.stateTF.isEnabled = false
            self.cityTF.isEnabled = false
            self.pinCodeTF.isEnabled = false
            self.dobTF.isEnabled = false
            self.dobBtn.isHidden = false
            self.stateButton.isHidden = false
            self.cityBtn.isHidden = false
            self.stateButton.isEnabled = false
            self.cityBtn.isEnabled = false
            self.dobBtn.isEnabled = false
            
            self.profileNameLbl.text = self.profileName
            self.mobileNumberLbl.text = self.mobileNumber
            self.locationLbl.text = self.location
            self.editOutBtn.setTitle("Edit Profile", for: .normal)
            print(self.profileImageURL)
            self.profileImage.kf.setImage(with: URL(string: "\(self.profileImageURL)"), placeholder: UIImage(named: "ic_default_img"))
            self.myProfileDetails()
        }
        
    }

    @IBAction func editActionBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("Check Internet Connection !!!", duration: 2.0,position: .bottom)
            }
        }else{
            if self.editOutBtn.currentTitle == "Edit Profile"{
                self.editOutBtn.setTitle("Save Changes", for: .normal)
                self.nameTF.isEnabled = false
                self.mobileNumberTF.isEnabled = false
                self.addressTF.isEnabled = true
                self.stateTF.isEnabled = false
                self.cityTF.isEnabled = false
                self.pinCodeTF.isEnabled = true
                self.dobBtn.isHidden = false
                self.stateButton.isEnabled = true
                self.cityBtn.isEnabled = true
                self.dobBtn.isEnabled = true
            }else if self.editOutBtn.currentTitle == "Save Changes"{
                // Api Call
                
                if self.nameTF.text!.count == 0{
                    self.view.makeToast("Enter name", duration: 2.0, position: .bottom)
                }else if self.mobileNumberTF.text!.count == 0{
                    self.view.makeToast("Enter mobile number", duration: 2.0, position: .bottom)
                }else if self.mobileNumberTF.text!.count != 10 {
                    self.view.makeToast("Enter valid mobile number", duration: 2.0, position: .bottom)
                }
                
                
                //            else if self.addressTF.text!.count == 0{
                //                self.view.makeToast("Enter address", duration: 2.0, position: .bottom)
                //            }
                //            else if self.stateTF.text == "Select State" || self.selectedStateId == -1{
                //                self.view.makeToast("Select State", duration: 2.0, position: .bottom)
                //            }
                else if self.selectedStateId != -1 && self.cityTF.text == "Select City" || self.selectedStateId != -1 && self.selectedCityId == -1{
                    self.view.makeToast("Select City", duration: 2.0, position: .bottom)
                }
                //            else if self.pinCodeTF.text!.count == 0{
                //                self.view.makeToast("Enter pin", duration: 2.0, position: .bottom)
                //            }
                else if self.pinCodeTF.text!.count != 6 && self.pinCodeTF.text!.count != 0{
                    self.view.makeToast("Enter valid pin", duration: 2.0, position: .bottom)
                }
                //            else if self.dobTF.text == "Select DOB"{
                //                self.view.makeToast("Select date of birth", duration: 2.0, position: .bottom)
                //            }
                else{
                    let parameter = [
                        "ActionType": "4",
                        "ActorId": "\(self.userID)",
                        "ObjCustomerJson": [
                            "Address1": "\(self.addressTF.text ?? "")",
                            "LocationId": "\(locationID)",
                            "cityid": "\(self.selectedCityId)",
                            "CountryId": 15,
                            "CustomerId": "\(self.customerId)",
                            "FirstName": "\(self.nameTF.text ?? "")",
                            "DOB": "\(self.dobTF.text ?? "")",
                            "Mobile": "\(self.mobileNumberTF.text ?? "")",
                            "RegistrationSource": "5",
                            "StateId": "\(self.selectedStateId)",
                            "Zip": "\(self.pinCodeTF.text ?? "")",
                            "MerchantId": "\(merchantID)",
                            "AddressId": "\(addressID)"
                        ]
                    ] as [String: Any]
                    print(parameter)
                    self.VM.myProfileUpdateApi(parameter: parameter)
                }
                
            }
        }
      
            
      }
    
    @IBAction func stateActBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("Check Internet Connection !!!", duration: 2.0,position: .bottom)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DropDownVC") as! DD_DropDownVC
            vc.delegate = self
            vc.itsFrom = "STATE"
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func cityActBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("Check Internet Connection !!!", duration: 2.0,position: .bottom)
            }
        }else{
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
    }
    
    
    @IBAction func dobActBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("Check Internet Connection !!!", duration: 2.0,position: .bottom)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DOBVC") as! DD_DOBVC
            vc.delegate = self
            vc.isComeFrom = "DOB"
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func cameraActBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("Check Internet Connection !!!", duration: 2.0,position: .bottom)
            }
        }else{
            let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
                self.openGallery()
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func myProfileDetails(){
        let parameter = [
            "ActionType": "6",
            "CustomerId": "\(self.userID)"
        ] as [String: Any]
        print(parameter)
        self.VM.myProfileApi(parameter: parameter)
    }
}

extension DD_MyProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func openGallery() {
        DispatchQueue.main.async {
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    DispatchQueue.main.async {
                        self.picker.allowsEditing = false
                        self.picker.sourceType = .photoLibrary
                        self.picker.mediaTypes = ["public.image"]
                        self.present(self.picker, animated: true, completion: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "Need Gallary access", message: "Allow Gallery Access", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                        let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                        }
                        alertVC.addAction(okAction)
                        alertVC.addAction(cancelAction)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            })
        }
        
    }
    func openCamera(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                            DispatchQueue.main.async {
                                self.picker.allowsEditing = false
                                self.picker.sourceType = UIImagePickerController.SourceType.camera
                                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                                self.picker.sourceType = .camera
                                self.picker.mediaTypes = ["public.image"]
                                self.present(self.picker,animated: true,completion: nil)
                            }
                        }            } else {
                            DispatchQueue.main.async {
                                let alertVC = UIAlertController(title: "Need Camera Access", message: "Allow Camera Access", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)
                            }
                            
                            
                        }
                }} else {
                    self.noCamera()
                }
        }
    }
    func opencamera() {
        DispatchQueue.main.async {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.present(self.picker,animated: true,completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "MSP customer Application need to access camera gallery", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "Disallow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
    func noCamera(){
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry no device", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        DispatchQueue.main.async { [self] in
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
            self.profileImage.image = selectedImage
            self.fileType = "JPG"
            let imageData = selectedImage.resized(withPercentage: 0.3)
            let imageData1: NSData = imageData!.pngData()! as NSData
            strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
            let parameter = [
                "ActorId": "\(self.userID)",
                    "ObjCustomerJson": [
                        "DisplayImage": "\(self.strdata1)"
                    ]
            ] as [String: Any]
            self.VM.myProfileImageUpdateApi(parameter: parameter)
            picker.dismiss(animated: true, completion: nil)
//                self.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")
      if string == numberFiltered {
          if textField == mobileNumberTF{
              let currentText = mobileNumberTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 10
          }else if textField == pinCodeTF {
              let currentText = pinCodeTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 6
          }
      
      } else {
        return false
      }
        return false
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
