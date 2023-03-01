//
//  DD_SidemenuVC.swift
//  DD_Motors
//
//  Created by ADMIN on 23/12/2022.
//

import UIKit
import SlideMenuControllerSwift
import CoreData
import Photos
import Kingfisher
import Lottie
class DD_SidemenuVC: BaseViewController {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var profileImage: UIButton!
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var membershipIdLbl: UILabel!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    
    var sideMenuArray = ["My Offers", "Subscription", "Subscription History", "Dealership Location", "Service History", "Support", "Terms & Conditions"]
    var sideMenuImage = ["myOffers", "badge", "badge", "location", "setting", "stack", "copy"]
    let picker = UIImagePickerController()
    var strBase64 = ""
    var fileType = ""
    var helpId = ""
    var strdata1 = ""
    var selectedIndex = -1
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    
    var profileName = ""
    var mobileNumber = ""
    var location = ""
    var profileImageURL = ""
    var VM = DD_SideMenuVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(closingSideMenu), name: Notification.Name.sideMenuClosing, object: nil)
        self.sideMenuTableView.isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(deletedAccount), name: Notification.Name.deleteAccount, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dashboardApi()
    }

    func dashboardApi(){
        let parameter = [
            "ActorId":"\(self.userID)"
        ] as [String: Any]
        self.VM.myProfileApi(parameter: parameter)
    }
    
    @objc func closingSideMenu(){
        self.closeLeft()
    }
    @objc func deletedAccount(){
        
        UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
//        self.clearTable()
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        if #available(iOS 13.0, *) {
            let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
            sceneDelegate?.setInitialViewAsRootViewController()

        } else {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.setInitialViewAsRootViewController()
        }
     
    }
    
    
    @IBAction func myProfileBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyProfileVC") as! DD_MyProfileVC
        print(self.profileName, "sadfsadfsadf")
        vc.profileName = self.profileName
        vc.mobileNumber = self.mobileNumber
        vc.location = self.location
        vc.profileImageURL = self.profileImageURL
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func deleteAccount(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Are you sure want to delete this account?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            
            UserDefaults.standard.set(false, forKey: "IsloggedIn?")
            UserDefaults.standard.set("" ,forKey: "result_UserID")
            UserDefaults.standard.set("" ,forKey: "result_Password")

            if #available(iOS 13.0, *) {
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setInitialViewAsRootViewController()
            }
        }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        }
    @IBAction func logoutBtn(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "IsloggedIn?")
        
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "UD_DEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "UD_DEVICE_TOKEN")
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
             //   self.clearTable2()
            }
        } else {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "UD_DEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "UD_DEVICE_TOKEN")
                if #available(iOS 13.0, *) {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setInitialViewAsRootViewController()
                }
            }
        }
    }
}
extension DD_SidemenuVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sideMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DD_SideMenuTVC", for: indexPath) as! DD_SideMenuTVC
        cell.selectionStyle = .none
        cell.categoryImage.image = UIImage(named: "\(self.sideMenuImage[indexPath.row])")
        cell.titleLbl.text = self.sideMenuArray[indexPath.row]
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.closeLeft()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1{
            self.closeLeft()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscriptionVC") as!
            DD_SubscriptionVC
            vc.itsFrom = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            self.closeLeft()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscriptionHistoryVC") as! DD_SubscriptionHistoryVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            self.closeLeft()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_DealershipLocationVC") as! DD_DealershipLocationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4{
            self.closeLeft()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_Service_HistoryVC") as! DD_Service_HistoryVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 5{
            self.closeLeft()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SupportVC") as! DD_SupportVC
            vc.itsFrom = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6{
            self.closeLeft()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_TermsandConditionsVC") as!  DD_TermsandConditionsVC
            self.navigationController?.pushViewController(vc, animated: true)
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
