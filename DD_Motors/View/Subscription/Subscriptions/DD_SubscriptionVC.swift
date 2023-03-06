//
//  DD_SubscriptionVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import UIKit
import Toast_Swift
import Lottie
class DD_SubscriptionVC: BaseViewController, SelectedItemDelegate {
    func subscriptionDidTap(_ vc: DD_DropDownVC) {
        self.selectedDealerTitle.text = vc.subscriptionTitle
        self.selectedTitle = vc.subscriptionTitle
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
    
    
    var selectedStatusId = -1
    var selectedTitle = ""
    var selectedSourceId = -1
    var VM = DD_SubscriptionDropDownVM()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var itsFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.amountLbl.isEnabled = false
        self.selectedStatusId = 1
        subView.clipsToBounds = false
        subView.layer.cornerRadius = 36
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.bookingIdImg.image = UIImage(named: "selected")
        self.yourVINImg.image = UIImage(named: "Ellipse 105")
        self.selectYourVRN.image = UIImage(named: "Ellipse 105")
        self.selectedStatusId = 1
        self.selectedSourceId = 1
        self.offlineSubscriptionView.backgroundColor = .white
        self.loaderView.isHidden = true
//        self.onlineSubscriptionView.backgroundColor = .white
        if self.itsFrom == "SideMenu"{
            self.backButton.isHidden = false
        }else{
            self.backButton.isHidden = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(goToDashBoard), name: Notification.Name.goToDashBoard, object: nil)
        
    }
    @objc func goToDashBoard(){
        if self.itsFrom == "SideMenu"{
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            tabBarController?.selectedIndex = 0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.selectedDealerTitle.text = "Select Type"
    }

    @IBAction func selectYourBookingId(_ sender: Any) {
        self.bookingIdImg.image = UIImage(named: "selected")
        self.yourVINImg.image = UIImage(named: "Ellipse 105")
        self.selectYourVRN.image = UIImage(named: "Ellipse 105")
        self.selectedStatusId = 1
    }
    @IBAction func selectYourVIN(_ sender: Any) {
        self.yourVINImg.image = UIImage(named: "selected")
        self.bookingIdImg.image = UIImage(named: "Ellipse 105")
        self.selectYourVRN.image = UIImage(named: "Ellipse 105")
        self.selectedStatusId = 2
    }
    @IBAction func selectYourVRNButton(_ sender: Any) {
        self.selectYourVRN.image = UIImage(named: "selected")
        self.yourVINImg.image = UIImage(named: "Ellipse 105")
        self.bookingIdImg.image = UIImage(named: "Ellipse 105")
        self.selectedStatusId = 3
    }
    
    @IBAction func selectCategoryBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DropDownVC") as! DD_DropDownVC
        vc.delegate = self
        vc.itsFrom = "SUBSCRIPTION"
        vc.selectedStatusId = self.selectedStatusId
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func onlineSubscriptionBnt(_ sender: Any) {
        self.selectedSourceId = 2
        self.onlineSubscriptionImage.image = UIImage(named: "selected")
        self.offlineSubscriptionImage.image = UIImage(named: "Ellipse 105")
        self.onlineSubscriptionView.backgroundColor = #colorLiteral(red: 0.9523764253, green: 0.9772849679, blue: 0.9983460307, alpha: 1)
        self.offlineSubscriptionView.backgroundColor = .white
    }
    
    @IBAction func offlineSubscriptionBnt(_ sender: Any) {
        self.selectedSourceId = 1
        self.offlineSubscriptionImage.image = UIImage(named: "selected")
        self.onlineSubscriptionImage.image = UIImage(named: "Ellipse 105")
        self.offlineSubscriptionView.backgroundColor = #colorLiteral(red: 0.9523764253, green: 0.9772849679, blue: 0.9983460307, alpha: 1)
        self.onlineSubscriptionView.backgroundColor = .white
    }
    @IBAction func proceedbtn(_ sender: Any) {
       
        if self.selectedStatusId == -1 {
            self.view.makeToast("Select Type", duration: 2.0, position: .bottom)
        }else if self.selectedTitle == ""{
            self.view.makeToast("Select Subscription type", duration: 2.0, position: .bottom)
        }else if self.selectedSourceId == -1{
            self.view.makeToast("Select Mode", duration: 2.0, position: .bottom)
        }else{
            self.startLoading()
            self.loaderView.isHidden = false
             self.playAnimation2()
            let parameter = [
                "ActionType":"1",
                "ActorId":"\(self.userID)",
                "LoyaltY_ID":"\(UserDefaults.standard.string(forKey: "LoyaltyId") ?? "")",
                "SourceType":"\(self.selectedSourceId)",
                "SourceId":"\(self.selectedStatusId)",
                "SourceValue":"\(self.selectedTitle)",
                "Amount":"999"
            ] as [String: Any]
            print(parameter)
            self.VM.subscriptionSubmission(parameter: parameter)
        }
    }
    
    @IBAction func myDescriptionbtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscriptionHistoryVC") as! DD_SubscriptionHistoryVC
        self.navigationController?.pushViewController(vc, animated: true)
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
    
}
