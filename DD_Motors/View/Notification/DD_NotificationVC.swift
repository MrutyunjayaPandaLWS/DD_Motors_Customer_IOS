//
//  DD_NotificationVC.swift
//  DD_Motors
//
//  Created by ADMIN on 29/12/2022.
//

import UIKit

class DD_NotificationVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var noDataFound: UILabel!
    
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var VM = HistoryNotificationsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.notificationTableView.delegate = self
        self.notificationTableView.dataSource = self
        notificationListApi()
    }

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func notificationListApi(){
        let parameters = [
            "ActionType": 0,
            "ActorId": self.userID,
            "LoyaltyId": self.loyaltyId
        ] as [String: Any]
        print(parameters)
        self.VM.notificationListApi(parameters: parameters) { response in
            self.VM.notificationListArray = response?.lstPushHistoryJson ?? []
            print(self.VM.notificationListArray.count)
            if self.VM.notificationListArray.count != 0 {
                DispatchQueue.main.async {
                    self.notificationTableView.isHidden = false
                    self.noDataFound.isHidden = true
                    self.notificationTableView.reloadData()
                }
            }else{
                self.noDataFound.isHidden = false
                self.notificationTableView.isHidden = true
            }
        }
        
    }
    
    
    func notificationDeleteApi(PushHistoryIds: Int){
        let parameters =  [
                "ActionType":"2",
                "ActorId":self.userID,
                "LoyaltyId":self.loyaltyId,
                "PushHistoryIds":"\(PushHistoryIds)"
            
        ] as [String: Any]
        print(parameters)
        self.VM.notificationDeleteApi(parameters: parameters) { response in
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.notificationListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DD_NotificationTVC", for: indexPath) as! DD_NotificationTVC

        cell.timeLbl.text = self.VM.notificationListArray[indexPath.row].jCreatedDate ?? ""
        let header = self.VM.notificationListArray[indexPath.row].title ?? ""
        let message = self.VM.notificationListArray[indexPath.row].pushMessage ?? ""
        cell.notificationMessageLbl.text = "\(message)"
        cell.notificationTitleLbl.text = "\(header)"
        cell.thickMarkImager.isHidden = self.VM.notificationListArray[indexPath.row].isSelected

//        if header.count != 0{
//            cell.notificationHeader.isHidden = false
//            cell.notificationHeader.text = header
//        }else{
//            cell.notificationHeader.isHidden = true
//        }
//        if message.count != 0{
//            cell.notificationMessage.isHidden = false
//            cell.notificationMessage.text = message
//        }else{
//            cell.notificationMessage.isHidden = true
//        }
        
        
//        cell.notificationImg.sd_setImage(with: URL(string: PROMO_IMG + receivedImage), placeholderImage: UIImage(named: "no_image1.jpg"))
//        let receivedImage = String(self.VM.notificationListArray[indexPath.row].imagesURL ?? "")
//        if  receivedImage != ""{
//            cell.imageView1.isHidden = false
//            cell.notificationImg.kf.setImage(with: URL(string: "\(Promo_ImageData)\(receivedImage.dropFirst(1))"), placeholder: UIImage(named: "no_image1.jpg"))
//        }else{
//            cell.imageView1.isHidden = true
//        }
//        cell.imageUrl = receivedImage
//        cell.delegate = self
        return cell

    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.VM.notificationListArray[indexPath.row].isSelected = false
        let indexpath =  IndexPath(row: indexPath.row, section: 0)
        self.notificationTableView.reloadRows(at: [indexpath], with: UITableView.RowAnimation.none)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            self.notificationDeleteApi(PushHistoryIds: self.VM.notificationListArray[indexPath.row].pushHistoryId ?? 0)
            self.VM.notificationListArray.remove(at: indexPath.row)
            self.notificationTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
    
}
