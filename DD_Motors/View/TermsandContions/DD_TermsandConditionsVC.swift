//
//  DD_TermsandConditionsVC.swift
//  DD_Motors
//
//  Created by Arokia-M3 on 23/12/22.
//

import UIKit
import Lottie
import WebKit
class DD_TermsandConditionsVC: UIViewController {
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    var tcListingArray = [LstTermsAndCondition]()
    var requestAPIs = RestAPI_Requests()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.isHidden = true
        self.dashboardTCApi()
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
           let htmlString = "\(htmlString)"
//        webview1.loadHTMLString(htmlString, baseURL: nil)
        webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
       }
    func dashboardTCApi(){
           DispatchQueue.main.async {
               self.loaderView.isHidden = false
               self.playAnimation2()
           }
           let parameters = [
               "ActionType": 1,
                "ActorId": 2
           ] as [String: Any]
           print(parameters)
           self.requestAPIs.termsAndCondion_API(parameters: parameters) { (result, error) in
               if error == nil{
                   if result != nil{
                       DispatchQueue.main.async {
                           self.loaderView.isHidden = true
                           self.tcListingArray = result?.lstTermsAndCondition ?? []
                           if self.tcListingArray.count == 0{
                               DispatchQueue.main.async{
                                   self.view.makeToast("No terms and Conditions Found", duration: 2.0, position: .center)
                               }
                           }else{
                                   for item in self.tcListingArray{
                                       if item.language == "English"{
                                           
                                           self.loadHTMLStringImage(htmlString: item.html ?? "")
                                           return
                                       }
                                   }
                               }
                           }
                   }else{
                       DispatchQueue.main.async {
                           self.loaderView.isHidden = true
                       }
                   }
               }else{
                   DispatchQueue.main.async {
                       self.loaderView.isHidden = true
                   }
               }
           }
       }
}
