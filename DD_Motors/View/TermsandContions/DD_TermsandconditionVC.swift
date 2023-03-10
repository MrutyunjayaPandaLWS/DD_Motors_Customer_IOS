//
//  DD_TermsandconditionVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import UIKit
import WebKit
import Lottie
class DD_TermsandconditionVC: BaseViewController {

    @IBOutlet weak var termsandContionsWebKit: WKWebView!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    @IBOutlet weak var loaderView: UIView!
     @IBOutlet weak var loaderAnimation: LottieAnimationView!
    
    private var loaderAnimationView : LottieAnimationView?
    var username = ""
    var password = ""
    var VM = DD_TermsandconditionVM()
    var tcListingArray = [LstTermsAndCondition]()
    var requestAPIs = RestAPI_Requests()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = false
        self.playAnimation2()
        self.checkBoxBtn.setImage(UIImage(named: "CheckBox 2"), for: .normal)
        self.dashboardTCApi()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            self.loaderView.isHidden = true
        }
    )
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkBoxButton(_ sender: Any) {
        if self.checkBoxBtn.currentImage == UIImage(named: "CheckedBox"){
            self.checkBoxBtn.setImage(UIImage(named: "CheckBox 2"), for: .normal)
        }else{
            self.checkBoxBtn.setImage(UIImage(named: "CheckedBox"), for: .normal)
        }
        
    }
    @IBAction func decline(_ sender: Any) {
        self.checkBoxBtn.setImage(UIImage(named: "CheckBox 2"), for: .normal)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptBtn(_ sender: Any) {
//        if self.checkBoxBtn.currentImage == UIImage(named: "CheckedBox"){
//            self.checkBoxBtn.setImage(UIImage(named: "CheckBox 2"), for: .normal)
//        }else{
        
        
        if checkBoxBtn.currentImage == UIImage(named:"CheckBox 2"){
            self.view.makeToast("Select Terms and Condition", duration: 2.0, position: .center)
            
        }else{
            //self.checkBoxBtn.setImage(UIImage(named: "CheckedBox"), for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.VM.loginSubmissionApi(username: self.username)
            })
        }
    }
    func loadHTMLStringImage(htmlString:String) -> Void {
           let htmlString = "\(htmlString)"
//        webview1.loadHTMLString(htmlString, baseURL: nil)
        termsandContionsWebKit.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
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
