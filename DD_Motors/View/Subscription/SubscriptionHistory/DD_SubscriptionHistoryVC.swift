//
//  DD_SubscriptionHistoryVC.swift
//  DD_Motors
//
//  Created by Arokia-M3 on 24/12/22.
//

import UIKit
import Lottie

class DD_SubscriptionHistoryVC: BaseViewController {

    @IBOutlet weak var subscriptionHistoryTV: UITableView!
    @IBOutlet var noDataFoundLbl: UILabel!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    
    
    var VM = DD_SubscriptionHistoryVM()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        self.subscriptionHistoryTV.delegate = self
        self.subscriptionHistoryTV.dataSource = self
        self.subscriptionHistoryTV.register(UINib(nibName: "DD_SubscriptionHistoryTVC", bundle: nil), forCellReuseIdentifier: "DD_SubscriptionHistoryTVC")
        self.subscriptionHistoryTV.separatorStyle = .none
        self.noDataFoundLbl.isHidden = true
        self.subscriptionListApi()
    }

    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    func subscriptionListApi(){
        let parameter = [
            "ActionType":"3",
            "ActorId":"\(self.userID)",
            "LoyaltY_ID":"\(self.loyaltyId)"
        ] as [String: Any]
        print(parameter)
        self.VM.myCashPointListingApi(parameter: parameter)
    }

}
extension DD_SubscriptionHistoryVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.subscriptionHistoryListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DD_SubscriptionHistoryTVC") as! DD_SubscriptionHistoryTVC
        cell.selectionStyle = .none
        cell.dateOfSubcriptionLbl.text = self.VM.subscriptionHistoryListingArray[indexPath.row].subscriptionDate ?? "-"
        cell.amountPaidLbl.text = "\(self.VM.subscriptionHistoryListingArray[indexPath.row].amount ?? 0)"
        if self.VM.subscriptionHistoryListingArray[indexPath.row].subscription ?? "" == "" || self.VM.subscriptionHistoryListingArray[indexPath.row].subscription ?? nil == nil{
            cell.subscribedLbl.text = "UNSUBSCRIBED"
        }else{
            cell.subscribedLbl.text = "SUBSCRIBED"
        }
        cell.subcriptionHistoryID.text = "\(self.VM.subscriptionHistoryListingArray[indexPath.row].sourceValue ?? "")"
        cell.paymentStatus.text = "\(self.VM.subscriptionHistoryListingArray[indexPath.row].sourceType ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
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
