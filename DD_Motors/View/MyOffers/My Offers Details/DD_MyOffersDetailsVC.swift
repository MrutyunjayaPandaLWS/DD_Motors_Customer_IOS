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

    @IBOutlet weak var detailsWebViewKit: WKWebView!
    @IBOutlet weak var offersTitleLbl: UILabel!
    
    @IBOutlet weak var offerIdTF: UITextField!
    
    @IBOutlet weak var redeemButton: UIButton!
    @IBOutlet weak var offersValidTill: UILabel!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView! 
    private var loaderAnimationView : LottieAnimationView?
    
    var VM = DD_MyOffersDetailsVM()
    var cardNumber = 0
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var termsandcondition = ""
    var howToUse = ""
    var desc = ""
    var expiredStatus = ""
    var itsFrom = "Description"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.offersDetailsApi(cardNo: "\(cardNumber)")
    }


    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func descriptionBtn(_ sender: Any) {
        self.itsFrom = "Description"
        offersDetailsApi(cardNo: "\(self.cardNumber)")
    }
    
    
    @IBAction func termsandConditions(_ sender: Any) {
        self.itsFrom = "TC"
        offersDetailsApi(cardNo: "\(self.cardNumber)")
    }
    @IBAction func useThisOfferBtn(_ sender: Any) {
        self.itsFrom = "Use"
        offersDetailsApi(cardNo: "\(self.cardNumber)")
    }
    
    @IBAction func redeemNowBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SuccessPopUp") as! DD_SuccessPopUp
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
