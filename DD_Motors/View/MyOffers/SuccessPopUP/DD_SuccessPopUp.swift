//
//  DD_SuccessPopUp.swift
//  DD_Motors
//
//  Created by ADMIN on 26/12/2022.
//

import UIKit
import Lottie
import SRScratchView
import CoreData
import Kingfisher
class DD_SuccessPopUp: UIViewController, SRScratchViewDelegate {
    
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    @IBOutlet weak var loaderView: UIView!
    
    @IBOutlet weak var scratchImageView: SRScratchView!
    @IBOutlet weak var congratulationView: UIView!
    @IBOutlet weak var scratchView: UIView!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var percentageLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var offerIdLbl: UILabel!
    @IBOutlet weak var successAnimation: AnimatedButton!
    private var animationView: LottieAnimationView?
    private var loaderAnimationView : LottieAnimationView?
    
    @IBOutlet weak var expiryDetailsConstrain: NSLayoutConstraint!
    @IBOutlet weak var openScratchView: UIButton!
    
    @IBOutlet weak var expiredTextLbl: UILabel!
    @IBOutlet weak var knowMoreOutBTN: UIButton!
    
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var called = 1
    var requestAPIs = RestAPI_Requests()
    var cardNumber = ""
    var offerReferenceID = ""
    var offerTitle = ""
    var isGiftID = 0
    var selcetedImage = ""
    var VM = DD_ScratchSubmissionVM()
    var sendImageView = ""
    var expiryData = 0
    var redeemData = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.expiredTextLbl.isHidden = true
        if self.expiryData == 1{
            self.expiredTextLbl.isHidden = false
            self.expiredTextLbl.text = "Expired"
            self.expiredTextLbl.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.1078313024)
            self.knowMoreOutBTN.isHidden = true
            self.expiryDetailsConstrain.constant = 0
        }else if redeemData == 1{
            self.expiredTextLbl.isHidden = false
            self.expiredTextLbl.text = "Redeemed"
            self.expiredTextLbl.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            self.expiredTextLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            self.knowMoreOutBTN.isHidden = true
            self.expiryDetailsConstrain.constant = 0
        }else{
            self.expiredTextLbl.isHidden = true
            self.knowMoreOutBTN.isHidden = false
        }
        
        
        
        print(self.isGiftID,"dkjhdksjhd")
        print(self.sendImageView)
        if self.isGiftID == 0{
            self.scratchView.isHidden = false
            self.congratulationView.isHidden = true
            self.scratchImageView.delegate = self
            self.scratchImageView.lineWidth = 0.1
            self.scratchImageView.lineType = .round
            self.scratchImageView.backgroundColor = UIColor.clear
        }else{
            self.scratchView.isHidden = true
            self.congratulationView.isHidden = false
        }
        self.loaderView.isHidden = true
        
//       self.scratchImageView.image = UIImage(named: "\(sendImageView)")
//        scratchImageView.kf.setImage(with: sendImageView)
        if sendImageView == "1"{
            scratchImageView.image = UIImage(named: "EnableBlue")
//            scratchImageView.kf.setImage(with: UIImage("EnableBlue"))
        }else{
            scratchImageView.image = UIImage(named: "EnableRed")
//            scratchImageView.kf.setImage(with: UIImage("EnableRed"))
        }
        let receivedImagePath = URL(string: "\(PROMO_IMG1)\(selcetedImage.dropFirst(2))")
        productImage.kf.setImage(with: receivedImagePath)
        self.successAnimation.isHidden = true
        self.infoLbl.text = self.offerTitle
    //    self.offerIdLbl.text = ""
        
        
        print(self.offerReferenceID)
        print(self.cardNumber)
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray]

        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.systemBlue]

           let attributedString1 = NSMutableAttributedString(string:"Offer ID ", attributes:attrs1)

        let attributedString2 = NSMutableAttributedString(string:"\(self.cardNumber)", attributes:attrs2)

           attributedString1.append(attributedString2)
           self.offerIdLbl.attributedText = attributedString1
      
    }
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)

        }
    }
    

    @IBAction func helpButton(_ sender: Any) {
        self.loaderView.isHidden = false
         self.playAnimation2()
        NotificationCenter.default.post(name: .navigateDetails, object: nil)
        self.dismiss(animated: true, completion: nil)
        self.loaderView.isHidden = false
    }
    
    @IBAction func knowDetailsBtn(_ sender: Any) {
        self.loaderView.isHidden = false
         self.playAnimation2()
        NotificationCenter.default.post(name: .navigateDetails, object: nil)
        self.dismiss(animated: true, completion: nil)
        self.loaderView.isHidden = true
        // Navigate to Details
        
    }
    
    @IBAction func openScratchViewAPI(_ sender: Any) {
        self.scratchSubmissionApi()
    }
    
    func playAnimation(){
        animationView = .init(name: "success")
          animationView!.frame = successAnimation.bounds
          // 3. Set animation content mode
          animationView!.contentMode = .scaleAspectFill
          // 4. Set animation loop mode
          animationView!.loopMode = .loop
          // 5. Adjust animation speed
          animationView!.animationSpeed = 0.5
        successAnimation.addSubview(animationView!)
          // 6. Play animation
          animationView!.play()
    }
    
    func scratchCardEraseProgress(eraseProgress: Float) {
        if eraseProgress > 0.1{
            self.scratchSubmissionApi()
        }
    }
    

    
//    {
//        "ActionType": "47",
//        "ActorId": "1871",
//        "CardNumber": "123",
//        "LoyaltyId": "9810040478",
//        "OfferReferenceID": "",
//        "Is_Gifited": "1"
//    }
    func scratchSubmissionApi(){
        let parameter = [
            "ActionType": "47",
            "ActorId": "\(self.userID)",
            "LoyaltyId":"\(self.loyaltyId)" ,
            "CardNumber":"\(self.cardNumber)",
            "OfferReferenceID":"\(self.offerReferenceID)",
            "Is_Gifited": "1"
        ] as [String: Any]
        print(parameter)
        self.VM.scratchStatusApi(parameter: parameter)
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
