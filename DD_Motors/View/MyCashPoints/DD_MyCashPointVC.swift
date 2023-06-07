//
//  DD_MyCashPointVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import UIKit
import Lottie

class DD_MyCashPointVC: BaseViewController, DateSelectedDelegate {
    func acceptDate(_ vc: DD_DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.fromDateLbl.text = vc.selectedDate
            self.fromDateLbl.textColor = .black
        }else{
            self.selectedToDate = vc.selectedDate
            self.toDateLbl.text = vc.selectedDate
            self.toDateLbl.textColor = .black
        }
    }
    
    func declineDate(_ vc: DD_DOBVC) {}
    

    @IBOutlet weak var debitLbl: UILabel!
    @IBOutlet weak var creditLbl: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var totalAvaliablePts: UILabel!
    @IBOutlet weak var totalEarningPts: UILabel!
    @IBOutlet weak var totalRedeemedPts: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var walletTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var noDataFoundLbl: UILabel!
    
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var debitedView: UIView!
    @IBOutlet weak var creditView: UIView!
    
    @IBOutlet weak var filterLbl: UILabel!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    @IBOutlet weak var filterResetOutBTN: UIButton!
    @IBOutlet var filterStackView: UIStackView!
    
    var VM = DD_MyCashPointVM()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var selectedFromDate = ""
    var selectedToDate = ""
    var selectedStatus = ""
    var itsFrom = ""
    var noofelements = 0
    var startindex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        backBtn.isHidden = true
        self.loaderView.isHidden = true
        walletTableView.dataSource = self
        walletTableView.delegate = self
        self.walletTableView.register(UINib(nibName: "DD_WalletListTVC", bundle: nil), forCellReuseIdentifier: "DD_WalletListTVC")
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subView.clipsToBounds = false
        subView.layer.cornerRadius = 36
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.allBtn.backgroundColor = UIColor(hexString: "204F99")
        self.allBtn.setTitleColor(.white, for: .normal)
        self.creditView.backgroundColor = UIColor(hexString: "F3F9FF")
        self.creditLbl.textColor = .black
        self.debitedView.backgroundColor = UIColor(hexString: "F3F9FF")
        self.debitLbl.textColor = .black
        self.filterLbl.text = "Filter"
        if self.itsFrom == "SideMenu"{
            self.backBtn.isHidden = false
        }else{
            self.backBtn.isHidden = true
        }
        self.VM.myCashPointListingArray.removeAll()
        self.myCashPointListApi(status: "", fromDate: "", toDate: "")
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func fromDateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DOBVC") as! DD_DOBVC
        vc.delegate = self
        vc.isComeFrom = "1"
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func toDateBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DOBVC") as! DD_DOBVC
        vc.delegate = self
        vc.isComeFrom = "2"
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        
        if self.filterLbl.text! == "Filter"{
            if self.selectedFromDate == "" && self.selectedToDate == ""{
                self.view.makeToast("Select date range", duration: 2.0, position: .bottom)
                
            }else if self.selectedFromDate != "" && self.selectedToDate == ""{
                self.view.makeToast("Select To Date", duration: 2.0, position: .bottom)
                
            }else if self.selectedFromDate == "" && self.selectedToDate != ""{
                self.view.makeToast("Select From Date", duration: 2.0, position: .bottom)
            }else if self.selectedFromDate != "" && self.selectedToDate != ""{
                if self.selectedFromDate > self.selectedToDate{
                    self.view.makeToast("To date shouldn't greater than from date", duration: 2.0, position: .bottom)
                }else{
                    
                    self.VM.myCashPointListingArray.removeAll()
                    self.filterLbl.text = "Reset"
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
                        
                        self.myCashPointListApi(status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
                    })
                }
                
            }
        }else if self.filterLbl.text! == "Reset"{
            self.selectedStatus = ""
            self.selectedToDate = ""
            self.selectedFromDate = ""
            self.fromDateLbl.text = "From Date"
            self.toDateLbl.text = "To Date"
            self.allBtn.backgroundColor = UIColor(hexString: "204F99")
            self.allBtn.setTitleColor(.white, for: .normal)
            self.creditView.backgroundColor = UIColor(hexString: "F3F9FF")
            self.creditLbl.textColor = .black
            self.debitedView.backgroundColor = UIColor(hexString: "F3F9FF")
            self.debitLbl.textColor = .black
            self.loaderView.isHidden = false
            self.VM.myCashPointListingArray.removeAll()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
                
                self.myCashPointListApi(status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
            })
            self.filterLbl.text = "Filter"
        }
//        else{
//            if self.selectedFromDate == "" && self.selectedToDate == "" ||  self.selectedFromDate != "" && self.selectedToDate != "" {
//                if self.selectedFromDate > self.selectedToDate{
//                    self.view.makeToast("To date shouldn't greater than from date", duration: 2.0, position: .bottom)
//                }else{
//                    self.loaderView.isHidden = false
//                    self.VM.myCashPointListingArray.removeAll()
//                    self.filterResetOutBTN.setTitle("Reset", for: .normal)
//                    DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
//                        
//                        self.myCashPointListApi(status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
//                    })
//                }
//            }
//        }
    }
    
    @IBAction func allBtn(_ sender: Any) {
        self.selectedStatus = ""
        self.allBtn.backgroundColor = UIColor(hexString: "204F99")
        self.allBtn.setTitleColor(.white, for: .normal)
        self.creditView.backgroundColor = UIColor(hexString: "F3F9FF")
        self.creditLbl.textColor = .black
        self.debitedView.backgroundColor = UIColor(hexString: "F3F9FF")
        self.debitLbl.textColor = .black
        self.loaderView.isHidden = false
        self.VM.myCashPointListingArray.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            
            self.myCashPointListApi(status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
        })
       
    }
    @IBAction func creditBtn(_ sender: Any) {
        self.selectedStatus = "Credited"
        self.allBtn.backgroundColor = UIColor(hexString: "F3F9FF")
        self.allBtn.setTitleColor(.black, for: .normal)
        self.creditView.backgroundColor = UIColor(hexString: "204F99")
        self.creditLbl.textColor = .white
        self.debitedView.backgroundColor = UIColor(hexString: "F3F9FF")
        self.debitLbl.textColor = .black
        self.loaderView.isHidden = false
        self.VM.myCashPointListingArray.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
          
            self.myCashPointListApi(status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
        })
    }
    @IBAction func debitBtn(_ sender: Any) {
        self.selectedStatus = "Debited"
        self.allBtn.backgroundColor = UIColor(hexString: "F3F9FF")
        self.allBtn.setTitleColor(.black, for: .normal)
        self.creditView.backgroundColor = UIColor(hexString: "F3F9FF")
        self.creditLbl.textColor = .black
        self.debitedView.backgroundColor = UIColor(hexString: "204F99")
        self.debitLbl.textColor = .white
        self.loaderView.isHidden = false
        self.VM.myCashPointListingArray.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.9, execute: {
            
            self.myCashPointListApi(status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
        })
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func myCashPointListApi(status: String, fromDate: String, toDate: String){
        let parameter = [
               "ActionType": "2",
               "ActorId": "\(self.userID )",
               "LOYALITY_ID":"\(UserDefaults.standard.string(forKey: "LoyaltyId") ?? "")",
               "FromDate": fromDate,
               "ToDate": toDate,
               "Status": status,
               "StartIndex":"\(startindex)",
               "PageSize":"10"
        ] as [String: Any]
        print(parameter)
        self.VM.myCashPointListingApi(parameter: parameter)
    }
    
}
extension DD_MyCashPointVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myCashPointListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DD_WalletListTVC", for: indexPath) as! DD_WalletListTVC
        cell.selectionStyle = .none
        
        let splitData = "\(self.VM.myCashPointListingArray[indexPath.row].jTranDate ?? "")".split(separator: " ")
//        cell.dateLbl.text = self.VM.myCashPointListingArray[indexPath.row].jTranDate ?? "00-00-0000"
        cell.dateLbl.text = "\(splitData[0])"
//        print(self.VM.myCashPointListingArray[indexPath.row].jTranDate,"dkjsd")
        let splitedData = self.VM.myCashPointListingArray[indexPath.row].remarks?.split(separator: "(")
        //let infolistData = splitedData.split(separator: "(")
        cell.infoLbl.text = "\(splitedData?[0] ?? "-")"
        if self.VM.myCashPointListingArray[indexPath.row].status ?? "-" == "0"{
            cell.statusLbl.text = "Debited"
            cell.pointsLbl.textColor = .red
            cell.pointsLbl.text = "-\(self.VM.myCashPointListingArray[indexPath.row].pointDebited ?? 0)"
            
            cell.arrowImage.image = UIImage(named: "arrow-down-right")
        }else if self.VM.myCashPointListingArray[indexPath.row].status ?? "-" == "1"{
            cell.statusLbl.text = "Credited"
            cell.pointsLbl.textColor = .green
            cell.pointsLbl.text = "+\(self.VM.myCashPointListingArray[indexPath.row].pointCredited ?? 0)"
            cell.arrowImage.image = UIImage(named: "arrow-down-left")
        }else{
            cell.statusLbl.text = "-"
            cell.pointsLbl.text = "0"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == VM.myCashPointListingArray.count - 2{
            if noofelements == 10{
                startindex = startindex + 1
                self.myCashPointListApi(status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
            }else if self.noofelements > 10{
                self.startindex = self.startindex + 1
                self.self.myCashPointListApi(status: self.selectedStatus, fromDate: self.selectedFromDate, toDate: self.selectedToDate)
            }else if noofelements < 10{
                print("no need to hit API")
                return
            }else{
                print("n0 more elements")
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
