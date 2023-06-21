//
//  DD_SupportVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import UIKit
import Lottie

class DD_SupportVC: BaseViewController, SendTopicDelegate{
    func sendTopicTapped(_ vc: DD_QueryTopicVC) {
        self.selectedQueryTopic = vc.selectedTopic
        self.selectedQueryTopicId = vc.selectedTopicId
        self.queryListApi(queryTopic: self.selectedQueryTopicId, statusId: self.selectedStatusId)
    }
    

    @IBOutlet weak var backButton: UIButton!
    
    //@IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedItem: UILabel!
    @IBOutlet weak var dropDownTableHeight: NSLayoutConstraint!
    @IBOutlet weak var dropDownTableView: UITableView!
    @IBOutlet weak var queryListingTableView: UITableView!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    var noofelements = 0
    var startindex = 1
    var tableHeight = 0
    var VM = DD_QueryListVM()
    var selectedQueryTopic = ""
    var selectedQueryTopicId = -1
    var itsFrom = ""
    
    var selectedStatus = ""
    var selectedStatusId = -1
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.dropDownTableView.isHidden = true
        self.loaderView.isHidden = true
        self.queryListingTableView.register(UINib(nibName: "DD_SupportTVC", bundle: nil), forCellReuseIdentifier: "DD_SupportTVC")
        queryListingTableView.delegate = self
        queryListingTableView.dataSource = self
        dropDownTableView.dataSource = self
        dropDownTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToNext), name: Notification.Name.navigateToNewQuery, object: nil)
        
        if self.itsFrom == "SideMenu"{
            self.backButton.isHidden = false
        }else{
            self.backButton.isHidden = true
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.selectedItem.text = "Filter"
            self.selectedStatusId = -1
            self.selectedQueryTopicId = -1
            self.VM.queryListArray.removeAll()
            self.queryListApi(queryTopic: self.selectedQueryTopicId, statusId: self.selectedStatusId)
            self.tableHeight = 0
            self.dropDownTableHeight.constant = 0
            //        self.bottomSpaceConstraint.constant = 3
            subView.clipsToBounds = false
            subView.layer.cornerRadius = 36
            
            subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    
    @objc func navigateToNext(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubmitQueryVC") as! DD_SubmitQueryVC
        vc.selectedTopic = self.selectedQueryTopic
        vc.selectedTopicId = self.selectedQueryTopicId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addQueryBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_QueryTopicVC") as! DD_QueryTopicVC
            vc.delegate = self
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func filterBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            if self.dropDownTableView.isHidden == false{
                self.dropDownTableView.isHidden = true
                self.tableHeight = 0
                self.dropDownTableHeight.constant = 0
                //            self.bottomSpaceConstraint.constant = 3
                // self.dropDownTableHeight.constant = CGFloat(self.tableHeight)
            }else{
                self.queryStatusListApi()
            }
        }
        
    }
    
    func queryListApi(queryTopic: Int, statusId: Int){
        let parameter = [
            "ActionType": "1",
            "ActorId": "\(self.userID)",
            "HelpTopicID": queryTopic,
            "TicketStatusId": statusId,
            "StartIndex":"\(startindex)",
            "PageSize":"10"
        ] as [String: Any]
        print(parameter)
        self.VM.querListsApi(parameter: parameter)
    }
    
    func queryStatusListApi(){
        let parameter = [
            "ActionType": 150
        ] as [String: Any]
        self.VM.queryTopicListApi(parameter: parameter)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension DD_SupportVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dropDownTableView{
            return self.VM.queryTopicListArray.count
        }else{
            return self.VM.queryListArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == dropDownTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DD_QueryDropTVC", for: indexPath) as! DD_QueryDropTVC
            cell.selectionStyle = .none
            cell.statusLbl.text = self.VM.queryTopicListArray[indexPath.row].attributeValue ?? ""
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DD_SupportTVC", for: indexPath) as! DD_SupportTVC
            cell.selectionStyle = .none
            cell.helpTopicLbl.text = self.VM.queryListArray[indexPath.row].helpTopic ?? ""
            cell.queryDetailsLbl.text = self.VM.queryListArray[indexPath.row].queryDetails ?? ""
            let receivedDate = String(self.VM.queryListArray[indexPath.row].jCreatedDate ?? "").split(separator: " ")
            if receivedDate.count != 0 {
                cell.dateLbl.text = "\(receivedDate[0])"
                cell.timeLbl.text = "\(receivedDate[1])"
            }
            cell.customerTicketRefNoLbl.text = self.VM.queryListArray[indexPath.row].customerTicketRefNo ?? ""
            cell.ticketStatusLbl.text = self.VM.queryListArray[indexPath.row].ticketStatus ?? ""
            
            
            if cell.ticketStatusLbl.text == "Pending"{
                cell.ticketStatusLbl.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.1495978123)
                cell.ticketStatusLbl.textColor = .red
            }else if cell.ticketStatusLbl.text == "Resolved" {
                cell.ticketStatusLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                cell.ticketStatusLbl.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }else{
                cell.ticketStatusLbl.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.ticketStatusLbl.textColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
            }
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == dropDownTableView{
            self.selectedItem.text = self.VM.queryTopicListArray[indexPath.row].attributeValue ?? ""
            self.selectedStatusId = self.VM.queryTopicListArray[indexPath.row].attributeId ?? 0
            self.dropDownTableView.isHidden = true
            self.tableHeight = 0
           // self.bottomSpaceConstraint.constant = 3
            self.dropDownTableHeight.constant = 0
            self.VM.queryListArray.removeAll()
            self.queryListApi(queryTopic: self.selectedQueryTopicId, statusId: self.selectedStatusId)
        }else{
            let centerviewcontroller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatListViewController") as! ChatListViewController
            // print(self.VM.queryListArray[indexPath.section].customerTicketID ?? 0)
            centerviewcontroller.CustomerTicketIDchatvc = "\(self.VM.queryListArray[indexPath.row].customerTicketID ?? 0)"
            centerviewcontroller.helptopicid = "\(self.VM.queryListArray[indexPath.row].helpTopicID ?? 0)"
            centerviewcontroller.querysummary = VM.queryListArray[indexPath.row].querySummary ?? ""
            centerviewcontroller.helptopicdetails = VM.queryListArray[indexPath.row].helpTopic ?? ""
            centerviewcontroller.querydetails = VM.queryListArray[indexPath.row].queryDetails ?? ""
            self.navigationController?.pushViewController(centerviewcontroller, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == dropDownTableView{
            return 35
        }else{
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView != dropDownTableView{
            if indexPath.row == VM.queryListArray.count - 1{
                if noofelements == 10{
                    startindex = startindex + 1
                    self.queryListApi(queryTopic: self.selectedQueryTopicId, statusId: self.selectedStatusId)
                }else if self.noofelements > 10{
                    self.startindex = self.startindex + 1
                    self.queryListApi(queryTopic: self.selectedQueryTopicId, statusId: self.selectedStatusId)
                }else if noofelements < 10{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
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
 
