//
//  DD_SubscriptionSubmissionPopUpVC.swift
//  DD_Motors
//
//  Created by ADMIN on 11/01/2023.
//

import UIKit
import Lottie
import SafariServices
import PDFKit
class DD_SubscriptionSubmissionPopUpVC: BaseViewController, UIDocumentInteractionControllerDelegate {

    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var successAnimatedView: LottieAnimationView!
    @IBOutlet weak var congratsPopUpView: LottieAnimationView!
    private var animationView: LottieAnimationView?
    var requestAPIs = RestAPI_Requests()
    var payMentId = ""
    var amount = ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    
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
            self.amountLbl.text = "999"
            playAnimation()
            playAnimation1()
        }
    }
    
//    func lottieAnimation1(animationView: LottieAnimationView){
//        animationView.contentMode = .scaleAspectFit
//        animationView.loopMode = .loop
//        animationView.animationSpeed = 0.5
//        animationView.play()
//
//    }
    
    @IBAction func generateReceiptBtn(_ sender: Any) {
        let parameter = [
            "ActionType": "4",
            "ActorId": "\(self.userID)",
            "LoyaltY_ID": "\(self.loyaltyId)",
            "PaymentID":"\(self.payMentId)"
        ] as [String: Any]
        print(parameter)
        self.generateReceiptApi(parameter: parameter)
    }
    func generateReceiptApi(parameter: JSON){
        self.requestAPIs.generateReceiptApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        if result?.pdf ?? "" != ""{
                            self.pdf(data1: result?.pdf ?? "")
                        }else{
                            self.stopLoading()
                            self.view.makeToast("Something went wrong. Try again later!", duration: 2.0, position: .bottom)
                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }
        }
    }
    func pdf(data1:String){
        
        guard let  data = Data(base64Encoded: data1) else {
            print("unable to convert base 64 string to data")
            return
        }
        let dateFormatter : DateFormatter = DateFormatter()
        //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Payment Receipt\(dateString).pdf")
        try! data.write(to: fileURL)
        let controller = UIDocumentInteractionController(url: fileURL)
        controller.delegate = self
        controller.presentPreview(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    func playAnimation(){
        animationView = .init(name: "33886-check-okey-done")
          animationView!.frame = congratsPopUpView.bounds
          // 3. Set animation content mode
          animationView!.contentMode = .scaleAspectFit
          // 4. Set animation loop mode
          animationView!.loopMode = .loop
          // 5. Adjust animation speed
          animationView!.animationSpeed = 0.5
        congratsPopUpView.addSubview(animationView!)
          // 6. Play animation
          animationView!.play()

    }

    func playAnimation1(){
        animationView = .init(name: "69030-confetti-full-screen")
          animationView!.frame = successAnimatedView.bounds
          // 3. Set animation content mode
          animationView!.contentMode = .scaleAspectFit
          // 4. Set animation loop mode
          animationView!.loopMode = .loop
          // 5. Adjust animation speed
          animationView!.animationSpeed = 0.5
        successAnimatedView.addSubview(animationView!)
          // 6. Play animation
          animationView!.play()

    }
}
