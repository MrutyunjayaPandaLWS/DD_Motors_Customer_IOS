//
//  DD_MyOffersDetailsVC.swift
//  DD_Motors
//
//  Created by ADMIN on 24/12/2022.
//

import UIKit
import WebKit
import Lottie
class DD_MyOffersDetailsVC: BaseViewController {

    @IBOutlet weak var offerBtn: UIButton!
    @IBOutlet weak var termsandConditionBtn: UIButton!
    @IBOutlet weak var descriptionBtn: UIButton!
    @IBOutlet weak var detailsWebViewKit: WKWebView!
    @IBOutlet weak var offersTitleLbl: UILabel!
    
    @IBOutlet weak var offerCategoryLbl: UILabel!
    @IBOutlet weak var offerIdTF: UITextField!
    
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet weak var offersValidTill: UILabel!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView! 
    private var loaderAnimationView : LottieAnimationView?
    
    @IBOutlet weak var offerrefernID: UILabel!
    var VM = DD_MyOffersDetailsVM()
    var cardNumber = 0
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var termsandcondition = ""
    var howToUse = ""
    var desc = ""
    var expiredStatus = ""
    var itsFrom = "Description"
    var offerId = ""
    var categoryId = -1
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
            self.itsFrom = "Description"
            self.offersDetailsApi(cardNo: "\(cardNumber)")
            self.descriptionBtn.setTitleColor(.white, for: .normal)
            self.descriptionBtn.backgroundColor = UIColor(hexString: "204FA4")
            self.termsandConditionBtn.setTitleColor(.lightGray, for: .normal)
            self.termsandConditionBtn.backgroundColor = .white
            self.offerBtn.setTitleColor(.lightGray, for: .normal)
            self.offerBtn.backgroundColor = .white
            self.offerrefernID.text = self.offerId
            NotificationCenter.default.addObserver(self, selector: #selector(navigateToNext), name: Notification.Name.navigateToSubscription, object: nil)
            if self.categoryId == 1{
                self.offerCategoryLbl.text = "Offers / Sales"
            }else if self.categoryId == 2{
                self.offerCategoryLbl.text = "Offers / Body Shop"
            }else if self.categoryId == 3{
                self.offerCategoryLbl.text = "Offers / Service"
            }else if self.categoryId == 4{
                self.offerCategoryLbl.text = "Offers / Insurance"
            }
        }
    }

    @objc func navigateToNext(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DealershipLocationVC") as! DD_DealershipLocationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func descriptionBtn(_ sender: Any) {
        self.itsFrom = "Description"
        self.offersDetailsApi(cardNo: "\(cardNumber)")
        self.descriptionBtn.setTitleColor(.white, for: .normal)
        self.descriptionBtn.backgroundColor = UIColor(hexString: "204FA4")
        self.termsandConditionBtn.setTitleColor(.lightGray, for: .normal)
        self.termsandConditionBtn.backgroundColor = .white
        self.offerBtn.setTitleColor(.lightGray, for: .normal)
        self.offerBtn.backgroundColor = .white
        
    }
    
    
    @IBAction func termsandConditions(_ sender: Any) {
        self.itsFrom = "TC"
        self.offersDetailsApi(cardNo: "\(self.cardNumber)")
        self.descriptionBtn.setTitleColor(.lightGray, for: .normal)
        self.descriptionBtn.backgroundColor = .white
        self.termsandConditionBtn.setTitleColor(.white, for: .normal)
        self.termsandConditionBtn.backgroundColor = UIColor(hexString: "204FA4")
        self.offerBtn.setTitleColor(.lightGray, for: .normal)
        self.offerBtn.backgroundColor = .white
    }
    @IBAction func useThisOfferBtn(_ sender: Any) {
        self.itsFrom = "Use"
        self.offersDetailsApi(cardNo: "\(self.cardNumber)")
        self.descriptionBtn.setTitleColor(.lightGray, for: .normal)
        self.descriptionBtn.backgroundColor = .white
        self.termsandConditionBtn.setTitleColor(.lightGray, for: .normal)
        self.termsandConditionBtn.backgroundColor = .white
        self.offerBtn.setTitleColor(.white, for: .normal)
        self.offerBtn.backgroundColor = UIColor(hexString: "204FA4")
    }
    
    @IBAction func redeemNowBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersDetailsPopUp") as! DD_MyOffersDetailsPopUp
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
    }
    
    func offersDetailsApi(cardNo: String){
        
        let parameter = [
            "ActionType": "45",
            "ActorId": "\(self.userID)",
            "CardNumber":cardNo
        ] as [String: Any]
        print(parameter)
        self.VM.myOffersListApi(parameter: parameter)
        
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
    func loadHTMLStringImage(htmlString:String) -> Void {
        let header = """
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
                    <style>
                        body {
                            font-family: "Avenir";
                            font-size: 15px;
                        }
                    </style>
                </head>
                <body>
                """
        detailsWebViewKit.loadHTMLString(header + htmlString + "</body>", baseURL: nil)
//           let htmlString = "\(htmlString)"
//        detailsWebViewKit.loadHTMLString(htmlString, baseURL: nil)
       }
}
