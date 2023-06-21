//
//  DD_DealershipLocationVC.swift
//  DD_Motors
//
//  Created by Arokia-M3 on 23/12/22.
//

import UIKit
import MapKit
import Lottie

class DD_DealershipLocationVC: BaseViewController, LocationRedirectDelegate, CLLocationManagerDelegate {
    func didTapMap(_ cell: DD_DealershipLocationTVC) {
        
        guard let tappedIndexPath = self.dealershipLocationTV.indexPath(for: cell) else {return}
        if cell.redirectBtn.tag == tappedIndexPath.row{
            self.latitude = Double(self.VM.dealerShipListArray[tappedIndexPath.row].latitude ?? "0")!
            self.longitude = Double(self.VM.dealerShipListArray[tappedIndexPath.row].longitude ?? "0")!
            self.locationName = self.VM.dealerShipListArray[tappedIndexPath.row].locationName ?? "0"
            print(self.latitude, self.longitude)
            
            let url = "http://maps.apple.com/maps?saddr=&daddr=\(latitude),\(longitude)"
            UIApplication.shared.openURL(URL(string:url)!)
//            // Navigate from one coordinate to another
//            let url = "http://maps.apple.com/maps?saddr=\(from.latitude),\(from.longitude)&daddr=\(to.latitude),\(to.longitude)"
//            UIApplication.shared.openURL(URL(string:url)!)
        }
    }
    
    
    @IBOutlet weak var dealershipLocationTV: UITableView!
    @IBOutlet var noDataFoundLbl: UILabel!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    
    
    
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var longitude = 0.0
    var latitude = 0.0
    var VM = DD_DealerShipLocationVM()
    var locationName = ""
    var noofelements = 0
    var startindex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.VM.VC = self
            self.loaderView.isHidden = true
            self.dealershipLocationTV.delegate = self
            self.dealershipLocationTV.dataSource = self
            self.dealershipLocationTV.register(UINib(nibName: "DD_DealershipLocationTVC", bundle: nil), forCellReuseIdentifier: "DD_DealershipLocationTVC")
            self.dealershipLocationTV.separatorStyle = .none
            self.dealerListingApi(startIndex: 1)
            self.VM.dealerShipListArray.removeAll()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.locationManager.startUpdatingLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.stopLoading()
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
   
        self.navigationController?.popViewController(animated: true)
    }
    
    func dealerListingApi(startIndex: Int){
        let parameter = [
            "ActionType": "248",
            "ActorId":"\(self.userID )",
            "ActiveStatusID": "1",
            "StartIndex": startIndex,
            "PageSize": "10"
        ] as [String: Any]
        print(parameter)
        self.VM.dealerShipLocationAPi(parameter: parameter)
    }
    

}
extension DD_DealershipLocationVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.dealerShipListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DD_DealershipLocationTVC") as! DD_DealershipLocationTVC
        cell.selectionStyle = .none
        cell.delegate = self
        cell.dealerNameLbl.text = self.VM.dealerShipListArray[indexPath.row].locationName ?? "-"
        cell.customerNameLbl.text = self.VM.dealerShipListArray[indexPath.row].ccName1 ?? "-"
        cell.locationHeadLbl.text = self.VM.dealerShipListArray[indexPath.row].ccName2 ?? "-"
        cell.managerHeadLbl.text = self.VM.dealerShipListArray[indexPath.row].ccName3 ?? "-"
        cell.contactPersionMobileNumberLbl.text = self.VM.dealerShipListArray[indexPath.row].ccMobile1 ?? "-"
        cell.locationHeadMobileNumberLbl.text = self.VM.dealerShipListArray[indexPath.row].ccMobile2 ?? "-"
        cell.managerHeadMobilenumberLbl.text = self.VM.dealerShipListArray[indexPath.row].ccMobile3 ?? "-"
        cell.redirectBtn.tag = indexPath.row
        
        cell.addressLbl.text = "\(self.VM.dealerShipListArray[indexPath.row].objLocationAddressInfo?.address1 ?? "-"), \(self.VM.dealerShipListArray[indexPath.row].objLocationAddressInfo?.zip ?? "-")"
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == VM.dealerShipListArray.count - 2{
                if noofelements == 10{
                    startindex = startindex + 1
                    self.dealerListingApi(startIndex: self.startindex)
                }else if self.noofelements > 10{
                    self.startindex = self.startindex + 1
                    self.dealerListingApi(startIndex: self.startindex)
                }else if noofelements < 10{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
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
