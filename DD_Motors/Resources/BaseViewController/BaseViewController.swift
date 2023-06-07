//
//  BaseViewController.swift
//  WalkKaro
//
//  Created by Arokia-M3 on 12/10/21.
//

import UIKit
import WebKit
import Lottie
//import SDWebImage
import Kingfisher
import SwiftUI
class BaseViewController: UIViewController {
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    
    var animationView1: LottieAnimationView?
    var myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let changeFontFamilyScript = "document.getElementsByTagName(\'body\')[0].style.fontFamily = \"Impact,Charcoal,sans-serif\";"
        webView.evaluateJavaScript(changeFontFamilyScript) { (response, error) in
            debugPrint("Am here")
        }
    }
    
    func convertDateFormater(_ date: String, fromDate: String, toDate: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = fromDate
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = toDate
        return dateFormatter.string(from: date!)
 
        }
//    var animationView: LottieAnimationView = {
//            var av = LottieAnimationView()
//
//            return av
//        }()
//
//        func initUI() {
//            self.view.backgroundColor = .white
//            animationView.backgroundColor = .white
//
//            view.addSubview(animationView)
//            animationView.translatesAutoresizingMaskIntoConstraints = false
//
//            animationView.widthAnchor.constraint(equalToConstant: 250).isActive = true
//            animationView.heightAnchor.constraint(equalToConstant: 250).isActive = true
//            animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//            animationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        }
    
       func startLoading(){
//           self.activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
//           activityIndicator.center = self.view.center;
//           activityIndicator.hidesWhenStopped = true;
//           activityIndicator.color = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
//           view.addSubview(activityIndicator);
//           activityIndicator.startAnimating();
////           self.startAnimation()
//           view.isUserInteractionEnabled = false
       }
    
    
//    func startAnimation() {
//            let path = Bundle.main.path(forResource: "loader.",
//                                        ofType: "json") ?? ""
//        animationView.animation = LottieAnimation.filepath(path)
//            animationView.contentMode = .scaleAspectFit
//            animationView.loopMode = .loop
//        animationView.animationSpeed = 0.5
//            animationView.play()
//
////        animationView!.frame = emptyVehicleAnimation.bounds
////        // 3. Set animation content mode
////        animationView!.contentMode = .scaleAspectFill
////        // 4. Set animation loop mode
////        animationView!.loopMode = .loop
////        // 5. Adjust animation speed
////        animationView!.animationSpeed = 0.5
////      emptyVehicleAnimation.addSubview(animationView!)
////        // 6. Play animation
////        animationView!.play()
//
//        }
    
       func stopLoading(){
        DispatchQueue.main.async {
//            self.activityIndicator.stopAnimating();
          //  self.view.isUserInteractionEnabled = true
        }
          
       }
    func lottieAnimation( animationView: LottieAnimationView){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()

    }

    func alertmsg(alertmsg:String, buttonalert:String){
        let alert = UIAlertController(title: "", message: alertmsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "\(buttonalert)", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}
