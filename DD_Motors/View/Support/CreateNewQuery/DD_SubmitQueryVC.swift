//
//  DD_CreateNewQueryVC.swift
//  DD_Motors
//
//  Created by ADMIN on 26/12/2022.
//

import UIKit
import Photos
import AVFoundation
import Lottie

class DD_SubmitQueryVC: BaseViewController, SelectedItemDelegate, UITextViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func subscriptionDidTap(_ vc: DD_DropDownVC) {}
    
    func stateDidTap(_ vc: DD_DropDownVC) {}
    func cityDidTap(_ vc: DD_DropDownVC) {}
    
    func helpTopicDidTap(_ vc: DD_DropDownVC) {
        self.selectedTopic = vc.helpTopicName
        self.selectedTopicId = vc.helpTopicId
        self.selectedTopicLbl.text = self.selectedTopic
    }
    

    @IBOutlet weak var selectedTopicLbl: UILabel!
    @IBOutlet weak var querySummaryTextView: UITextView!
    @IBOutlet weak var queryDetailsTextView: UITextView!
    
    @IBOutlet weak var attachedImage1: UIImageView!
    
    @IBOutlet weak var attachedImage2: UIImageView!
    
    @IBOutlet weak var attachedImage3: UIImageView!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
   private var loaderAnimationView : LottieAnimationView?
    
    var selectedTopic = ""
    var selectedTopicId = -1
    var strdata1 = ""
    var strdata2 = ""
    var strdata3 = ""
    let picker = UIImagePickerController()
    var querySummaryDetails = ""
    var itsFrom = ""
    var VM = DD_SubmitNewQueryVM()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var imageListArray = [String:Any]()
    var imageListArray1 = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.querySummaryTextView.delegate = self
        self.queryDetailsTextView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.selectedTopicLbl.text = self.selectedTopic
        
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func offersRelatedDropDownBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DropDownVC") as! DD_DropDownVC
        vc.delegate = self
        vc.itsFrom = "HELP"
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func removeImageoneBtn(_ sender: Any) {
        self.strdata1 = ""
        self.attachedImage1.image = UIImage(named: "ic_default_img")
    }
    
    @IBAction func removeImageTwoBtn(_ sender: Any) {
        self.strdata2 = ""
        self.attachedImage2.image = UIImage(named: "ic_default_img")
    }
    
    @IBAction func removeImageThreeBtn(_ sender: Any) {
        self.strdata3 = ""
        self.attachedImage3.image = UIImage(named: "ic_default_img")
    }
    @IBAction func browseImageBtn(_ sender: Any) {
        if self.strdata1 == "" && self.strdata2 == "" && self.strdata3 == ""{
            self.itsFrom = "Image1"
        }else if self.strdata1 != "" && self.strdata2 == "" && self.strdata3 == ""{
            self.itsFrom = "Image2"
        }else if self.strdata1 != "" && self.strdata2 != "" && self.strdata3 == ""{
            self.itsFrom = "Image3"
        }
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
    @IBAction func submitQueryBNtm(_ sender: Any) {
        self.imageListArray1.removeAll()
        if self.selectedTopicLbl.text == ""{
            self.view.makeToast("Select query topic", duration: 3.0, position: .bottom)
        }else if self.querySummaryTextView.text!.count == 0{
            self.view.makeToast("Enter query summary", duration: 3.0, position: .bottom)
        }else if self.queryDetailsTextView.text!.count == 0{
            self.view.makeToast("Enter query details", duration: 3.0, position: .bottom)
        }else{
            
            if self.strdata1 != "" && self.strdata2 == "" && self.strdata3 == ""{
                let parameter = [
                    "ActionType": "3",
                    "ActorId": "\(self.userID)",
                    "CustomerName": "null",
                    "Email": "null",
                    "HelpTopic": "\(self.selectedTopic)",
                    "HelpTopicID": "\(self.selectedTopicId)",
                    "IsQueryFromMobile": "true",
                    "LoyaltyID": "\(self.loyaltyId)",
                    "QueryDetails": "\(self.queryDetailsTextView.text!)",
                    "QuerySummary": "\(self.querySummaryTextView.text!)",
                    "SourceType": "1",
                    "ImageUrl": "",
                    "lstcustomereQueryImgPathGalleryLists": [
                        [
                        "ImageAttachMent": "\(self.strdata1)"
                        ]
                    ]
                ] as [String: Any]
                print(parameter, "Single Image")
                self.VM.querySubmissionApi(parameter: parameter)
            }else if self.strdata1 != "" && self.strdata2 != "" && self.strdata3 == ""{
                
                self.imageListArray1 = [
                    [
                        "ImageAttachMent": "\(self.strdata1)"
                    ],
                    [
                        "ImageAttachMent": "\(self.strdata2)"
                    ]
                ] as [[String: Any]]
                
                let parameter = [
                    "ActionType": "3",
                    "ActorId": "\(self.userID)",
                    "CustomerName": "null",
                    "Email": "null",
                    "HelpTopic": "\(self.selectedTopic)",
                    "HelpTopicID": "\(self.selectedTopicId)",
                    "IsQueryFromMobile": "true",
                    "LoyaltyID": "\(self.loyaltyId)",
                    "QueryDetails": "\(self.queryDetailsTextView.text!)",
                    "QuerySummary": "\(self.querySummaryTextView.text!)",
                    "SourceType": "1",
                    "ImageUrl": "",
                    "lstcustomereQueryImgPathGalleryLists": self.imageListArray1
                ] as [String: Any]
                print(parameter, "Two Images submission")
                self.VM.querySubmissionApi(parameter: parameter)
            }else if self.strdata1 != "" && self.strdata2 != "" && self.strdata3 != ""{
                let parameter = [
                    "ActionType": "3",
                    "ActorId": "\(self.userID)",
                    "CustomerName": "null",
                    "Email": "null",
                    "HelpTopic": "\(self.selectedTopic)",
                    "HelpTopicID": "\(self.selectedTopicId)",
                    "IsQueryFromMobile": "true",
                    "LoyaltyID": "\(self.loyaltyId)",
                    "QueryDetails": "\(self.queryDetailsTextView.text!)",
                    "QuerySummary": "\(self.querySummaryTextView.text!)",
                    "SourceType": "1",
                    "ImageUrl": "",
                    "lstcustomereQueryImgPathGalleryLists": self.imageListArray1
                ] as [String: Any]
                print(parameter, "Three Images submission")
                self.VM.querySubmissionApi(parameter: parameter)
            }
                  
        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.querySummaryTextView.text == "Query Summary"{
            self.querySummaryTextView.text = ""
            if self.queryDetailsTextView.text.count == 0 {
                self.querySummaryTextView.text = "Write your query details..."
            }
        }else if self.queryDetailsTextView.text == "Write your query details..."{
            self.queryDetailsTextView.text = ""
            if self.querySummaryTextView.text.count == 0{
                self.querySummaryTextView.text = "Query Summary"
            }
        }
        

    }
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
            let imageData = selectedImage.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            print(self.itsFrom)
            
            if self.itsFrom == "Image1"{
                self.attachedImage1.image = selectedImage
              self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
            }else if self.itsFrom == "Image2"{
                self.attachedImage2.image = selectedImage
                self.strdata2 = imageData1.base64EncodedString(options: .lineLength64Characters)
            }else if self.itsFrom == "Image3"{
                self.attachedImage3.image = selectedImage
                self.strdata3 = imageData1.base64EncodedString(options: .lineLength64Characters)
            }
            
            picker.dismiss(animated: true, completion: nil)
//                self.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
