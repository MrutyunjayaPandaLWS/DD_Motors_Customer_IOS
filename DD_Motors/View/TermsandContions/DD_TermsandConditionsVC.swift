//
//  DD_TermsandConditionsVC.swift
//  DD_Motors
//
//  Created by Arokia-M3 on 23/12/22.
//

import UIKit
import Lottie
class DD_TermsandConditionsVC: UIViewController {
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet var webView: UIWebView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView! 
    private var loaderAnimationView : LottieAnimationView?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.isHidden = true
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
}
