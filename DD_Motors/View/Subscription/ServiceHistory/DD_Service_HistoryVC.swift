//
//  DD_Service HistoryVC.swift
//  DD_Motors
//
//  Created by Arokia-M3 on 23/12/22.
//

import UIKit
import Lottie
class DD_Service_HistoryVC: BaseViewController {

    @IBOutlet weak var serviceHistoryTableView: UITableView!
    @IBOutlet var noDataFoundLbl: UILabel!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    
    var noofelements = 0
    var startindex = 1
    var VM = DD_ServiceHistoryVM()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.VM.VC = self
            self.loaderView.isHidden = true
            self.serviceHistoryTableView.delegate = self
            self.serviceHistoryTableView.dataSource = self
            self.serviceHistoryTableView.register(UINib(nibName: "DD_ServiceHistoryTVC", bundle: nil), forCellReuseIdentifier: "DD_ServiceHistoryTVC")
            self.serviceHistoryTableView.separatorStyle = .none
            self.noDataFoundLbl.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.VM.serviceHistoryListingArray.removeAll()
            self.serviceHistoryListApi(startIndex: 1)
        }
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func serviceHistoryListApi(startIndex: Int){
        let parameter = [
            "ActionType": "262",
            "ActorId": "\(self.userID)",
            "LoyaltyID": "\(self.loyaltyId)",
            "StartIndex": startIndex,
            "PageSize":"10"
        ] as [String: Any]
        print(parameter)
        self.VM.serviceHistoryListApi(parameter: parameter)
    }
    
    

}
extension DD_Service_HistoryVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.serviceHistoryListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DD_ServiceHistoryTVC") as! DD_ServiceHistoryTVC
        cell.selectionStyle = .none
        cell.mobileNumberLbl.text = self.VM.serviceHistoryListingArray[indexPath.row].loyaltyId ?? "-"
        cell.contactPersionLbl.text = self.VM.serviceHistoryListingArray[indexPath.row].name ?? "-"
        cell.locationLbl.text = self.VM.serviceHistoryListingArray[indexPath.row].locationCode ?? "-"
        cell.modelLbl.text = self.VM.serviceHistoryListingArray[indexPath.row].model ?? "-"
        let txrnDate = String(self.VM.serviceHistoryListingArray[indexPath.row].tnxDate ?? "-").split(separator: " ")
        if txrnDate.count != 0{
            cell.dateOfServiceLbl.text = "\(txrnDate[0])"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == VM.serviceHistoryListingArray.count - 2{
            if noofelements == 10{
                startindex = startindex + 1
                self.serviceHistoryListApi(startIndex: self.startindex)
            }else if self.noofelements > 10{
                self.startindex = self.startindex + 1
                self.serviceHistoryListApi(startIndex: self.startindex)
            }else if noofelements < 10{
                print("no need to hit API")
                return
            }else{
                print("no more elements")
                return
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
