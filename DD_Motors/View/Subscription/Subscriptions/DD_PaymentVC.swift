//
//  DD_PaymentVC.swift
//  DD_Motors
//
//  Created by ADMIN on 21/03/2023.
//

import Foundation
import UIKit
import CashfreePGCoreSDK
import CashfreePGUISDK
import CashfreePG
import Lottie

protocol SendBackDetails: AnyObject{
    func paymentFailed(_ vc: DD_PaymentVC)
}
class DD_PaymentVC: BaseViewController {
    
    @IBOutlet weak var paymentLoaderView: LottieAnimationView!
    
    private let cfPaymentGatewayService = CFPaymentGatewayService.getInstance()

    var orderID = ""
    var paymentToken = ""
    var itsFrom = ""
    var selectedStatusId = ""
    var selectedTitle = ""
    var selectedSourceId = ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var delegate: SendBackDetails!

    var VM = DD_PaymentVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                self.view.makeToast("Check Internet Connection !!!", duration: 2.0,position: .bottom)
            }
        }else{
            self.VM.VC = self
            if itsFrom == "Main"{
                lottieAnimation1(animationView: paymentLoaderView)
                self.itsFrom = ""
            }else{
                self.paymentLoaderView.isHidden = true
            }
            
            self.cfPaymentGatewayService.setCallback(self)
            DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {
                self.invokeNativeiOSSDK()
            })
        }
    }
    func lottieAnimation1(animationView: LottieAnimationView){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()

    }
    
    func paymentSubmissionApi(){
        let parameter = [
            "ActionType": "1",
            "ActorId": "\(self.userID)",
            "Amount": "885",
            "LoyaltY_ID": "\(UserDefaults.standard.string(forKey: "LoyaltyId") ?? "")",
            "SourceId": self.selectedStatusId, // 1-->>BookingID,2-->>VIN, 3-->>VRN
            "SourceType": "3",// 1-->> Android, 3-->>IOS
            "SourceValue": self.selectedTitle,
            "SubscriptionTypeId": self.selectedSourceId,// 1-->> Offline, 2-->>Online
            "SubscriptionStatus":"1",
            "PaymentID":"\(self.orderID)"
        ] as [String: Any]
        print(parameter)
        self.VM.subscriptionSubmission(parameter: parameter)
        
    }
    
    
    func invokeNativeiOSSDK() {
        if let session = self.getSession() {
            do {
              
                // Set Components
                    let paymentComponents = try CFPaymentComponent.CFPaymentComponentBuilder()
                        .enableComponents([
                            "order-details",
                            "card",
                            "paylater",
                            "wallet",
                            "emi",
                            "netbanking",
                            "upi"
                        ])
                        .build()
                    
                    // Set Theme
                    let theme = try CFTheme.CFThemeBuilder()
                        .setPrimaryFont("Source Sans Pro")
                        .setSecondaryFont("Gill Sans")
                        .setButtonTextColor("#FFFFFF")
                        .setButtonBackgroundColor("#FF0000")
                        .setNavigationBarTextColor("#FFFFFF")
                        .setNavigationBarBackgroundColor("#FF0000")
                        .setPrimaryTextColor("#FF0000")
                        .setSecondaryTextColor("#FF0000")
                        .build()
                    
                    // Native payment
                    let nativePayment = try CFDropCheckoutPayment.CFDropCheckoutPaymentBuilder()
                        .setSession(session)
                        .setTheme(theme)
                        .setComponent(paymentComponents)
                        .build()
                    
                    // Invoke SDK
                    try self.cfPaymentGatewayService.doPayment(nativePayment, viewController: self)
            } catch let e {
                let error = e as! CashfreeError
                print(error.localizedDescription)
                // Handle errors here
            }
        }
    }
    
    private func getSession() -> CFSession? {
            do {
                    let session = try CFSession.CFSessionBuilder()
                       .setEnvironment(.SANDBOX)
                       .setOrderID(self.orderID)
                       .setPaymentSessionId(self.paymentToken)
                       .build()
                   return session
           } catch let e {
               let error = e as! CashfreeError
               print(error.localizedDescription)
               // Handle errors here
           }
           return nil
       }

}
extension DD_PaymentVC: CFResponseDelegate {
    
    func onError(_ error: CFErrorResponse, order_id: String) {
        print(error.message)
        self.delegate?.paymentFailed(self)
        self.navigationController?.popViewController(animated: true)
    }
    
    func verifyPayment(order_id: String) {
        // Verify The Payment here
        self.paymentSubmissionApi()
    }
    
}

