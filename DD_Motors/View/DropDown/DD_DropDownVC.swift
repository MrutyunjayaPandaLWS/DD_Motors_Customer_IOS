//
//  DD_DropDownVC.swift
//  DD_Motors
//
//  Created by ADMIN on 24/12/2022.
//

import UIKit
import Lottie
protocol SelectedItemDelegate: AnyObject{
    func stateDidTap(_ vc: DD_DropDownVC)
    func cityDidTap(_ vc: DD_DropDownVC)
    func helpTopicDidTap(_ vc: DD_DropDownVC)
    func subscriptionDidTap(_ vc: DD_DropDownVC)
}
class DD_DropDownVC: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    

    @IBOutlet weak var dropDownTableView: UITableView!
    
    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    
    var itsFrom = ""
    var selectedStateId = -1
    var selectedStateName = ""
    var selectedCityId = -1
    var selectedCityName = ""
    var helpTopicName = ""
    var helpTopicId = -1
    var subscriptionId = -1
    var subscriptionTitle = ""
    
    var selectedStatusId = -1
    var subscriptionStatusId = -1
    var delegate : SelectedItemDelegate!
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    
    var VM = DD_DropDownVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownTableView.delegate = self
        dropDownTableView.dataSource = self
        self.loaderView.isHidden = true
        self.noDataFoundLbl.isHidden = true
        self.VM.VC = self
        if self.itsFrom == "STATE"{
            self.stateApi()
        }else if self.itsFrom == "CITY"{
            self.cityApi()
        }else if self.itsFrom == "HELP"{
            self.getHelpTopicApi()
        }else if self.itsFrom == "SUBSCRIPTION"{
            self.subscriptionListApi()
        }
      
    }
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)

        }
    }
    func stateApi(){
        let parameter = [
            "ActionType":"2",
            "CountryID":15,
            "IsActive":"true",
            "SortColumn":"STATE_NAME",
            "SortOrder":"ASC",
            "StartIndex":"1"
        ] as [String: Any]
        self.VM.stateListApi(parameter: parameter)
    }
    func cityApi(){
        let parameter = [
            "ActionType":"2",
            "IsActive":"true",
            "SortColumn":"CITY_NAME",
            "SortOrder":"ASC",
            "StateId":self.selectedStateId
        ] as [String: Any]
        print(parameter)
        self.VM.cityListApi(parameter: parameter)
        
    }
    func getHelpTopicApi(){
        let parameter = [
            "ActionType": "4",
            "ActorId": "\(self.userID)",
               "IsActive": "true"
        ] as [String: Any]
        self.VM.helpTopiceListAPi(parameter: parameter)
    }
    
    func subscriptionListApi(){
        let parameter = [
//            "ActionType":"1",
//            "ActorId":"\(self.userID)",
//            "LoyaltY_ID":"\(self.loyaltyId)"
            "ActionType":"2",
            "ActorId":"\(self.userID)",
            "SourceId":"\(self.selectedStatusId)"
        ] as [String: Any]
        print(parameter)
        self.VM.myCashPointListingApi(parameter: parameter)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.itsFrom == "STATE"{
            return self.VM.stateListArray.count
        }else if self.itsFrom == "CITY"{
            return self.VM.cityListArray.count
        }else if self.itsFrom == "HELP"{
            return self.VM.helpTopicListArray.count
        }else if self.itsFrom == "SUBSCRIPTION"{
            return self.VM.subscriptionHistoryListingArray.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DD_DropDownTVC", for: indexPath) as! DD_DropDownTVC
        if self.itsFrom == "STATE"{
            cell.selectedItemLbl.text = self.VM.stateListArray[indexPath.row].stateName ?? ""
        }else if self.itsFrom == "CITY"{
            cell.selectedItemLbl.text = self.VM.cityListArray[indexPath.row].cityName ?? ""
        }else if self.itsFrom == "HELP"{
            cell.selectedItemLbl.text = self.VM.helpTopicListArray[indexPath.row].helpTopicName ?? ""
        }else if self.itsFrom == "SUBSCRIPTION"{
            cell.selectedItemLbl.text = self.VM.subscriptionHistoryListingArray[indexPath.row].subscription ?? ""
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.itsFrom == "STATE"{
            self.selectedStateName = self.VM.stateListArray[indexPath.row].stateName ?? ""
            self.selectedStateId = self.VM.stateListArray[indexPath.row].stateId ?? -1
            print(self.selectedStateId,"dljkdk")
            self.delegate.stateDidTap(self)
        }else if self.itsFrom == "CITY"{
            self.selectedCityName = self.VM.cityListArray[indexPath.row].cityName ?? ""
            self.selectedCityId = self.VM.cityListArray[indexPath.row].cityId ?? -1
            print(self.selectedCityId,"dljkdk")
            self.delegate.cityDidTap(self)
        }else if self.itsFrom == "HELP"{
            self.helpTopicName = self.VM.helpTopicListArray[indexPath.row].helpTopicName ?? ""
            self.helpTopicId = self.VM.helpTopicListArray[indexPath.row].helpTopicId ?? -1
            self.delegate.helpTopicDidTap(self)
        }else if self.itsFrom == "SUBSCRIPTION"{
            self.subscriptionTitle = self.VM.subscriptionHistoryListingArray[indexPath.row].subscription ?? ""
            self.subscriptionStatusId = self.VM.subscriptionHistoryListingArray[indexPath.row].subscriptionStatus ?? -1
            print(subscriptionTitle)
            print(subscriptionStatusId)
            self.delegate.subscriptionDidTap(self)
        }
        self.dismiss(animated: true, completion: nil)
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
