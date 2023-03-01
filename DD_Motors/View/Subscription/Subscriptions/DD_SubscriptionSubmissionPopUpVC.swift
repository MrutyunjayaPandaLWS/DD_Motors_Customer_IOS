//
//  DD_SubscriptionSubmissionPopUpVC.swift
//  DD_Motors
//
//  Created by ADMIN on 11/01/2023.
//

import UIKit
import Lottie
class DD_SubscriptionSubmissionPopUpVC: UIViewController {

    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var successAnimatedView: LottieAnimationView!
    @IBOutlet weak var congratsPopUpView: LottieAnimationView!
    private var animationView: LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        playAnimation()
        playAnimation1()
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
