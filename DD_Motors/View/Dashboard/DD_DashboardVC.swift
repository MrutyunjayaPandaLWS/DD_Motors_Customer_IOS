//
//  DD_DashboardVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

import SDWebImage
import UIKit
import ImageSlideshow
import Lottie
import SlideMenuControllerSwift
import CoreData
import Alamofire
import Kingfisher

class DD_DashboardVC: BaseViewController{

    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var watchSpaceLbl: UILabel!
    @IBOutlet weak var vehicleView: UIView!
    @IBOutlet weak var myVehicelLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var memberShipIdLbl: UILabel!
    @IBOutlet weak var bannerImageSlideShow: ImageSlideshow!
    @IBOutlet weak var emptyBannerImage: UIImageView!
    @IBOutlet weak var emptyVehicleAnimation: LottieAnimationView!
    @IBOutlet weak var myVehicleCollectionView: UICollectionView!
    @IBOutlet weak var maintenanceView: UIView!
    @IBOutlet weak var underMaintenance: LottieAnimationView!
    
    private var animationView: LottieAnimationView?
    private var loaderAnimationView : LottieAnimationView?
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var VM = DD_DashBoardVM()
    var requestAPIs = RestAPI_Requests()
    var sourceArray = [AlamofireSource]()
    var bannerImagesArray = [ObjImageGalleryList1]()
    var bannerImageCalled = 0
    override func viewDidLoad() {
        super.viewDidLoad()
            self.VM.VC = self
            self.countLbl.isHidden =  true
            myVehicleCollectionView.delegate = self
            myVehicleCollectionView.dataSource = self
        self.maintenanceView.isHidden = true
            let collectionViewFLowLayout = UICollectionViewFlowLayout()
            
            collectionViewFLowLayout.itemSize = CGSize(width: (self.view.bounds.width - 10 - (self.myVehicleCollectionView.contentInset.left + self.myVehicleCollectionView.contentInset.right)) / 2, height: 210)
            collectionViewFLowLayout.minimumLineSpacing = 2.5
            collectionViewFLowLayout.minimumInteritemSpacing = 2.5
            collectionViewFLowLayout.scrollDirection = .horizontal
            self.myVehicleCollectionView.collectionViewLayout = collectionViewFLowLayout
            NotificationCenter.default.addObserver(self, selector: #selector(goBackToLogin), name: Notification.Name.accountDeactivated, object: nil)
        
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
            if self.VM.sourceArray.isEmpty{
                self.bannerImageApi()
            }
            self.slideMenuController()?.closeLeft()
            self.loaderView.isHidden = false
            self.playAnimation2()
            self.bannerImageCalled = 1
            self.tokendata()
            self.maintenanceAPI()
            self.isUpdateAvailable()
        }
        
    }
    
    @objc func goBackToLogin(){
        
        UserDefaults.standard.set(false, forKey: "IsloggedIn?")
        if #available(iOS 13.0, *) {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "SMSDEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "SMSDEVICE_TOKEN")
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
             //   self.clearTable2()
            }
        } else {
            DispatchQueue.main.async {
                let pushID = UserDefaults.standard.string(forKey: "SMSDEVICE_TOKEN") ?? ""
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                UserDefaults.standard.setValue(pushID, forKey: "SMSDEVICE_TOKEN")
                if #available(iOS 13.0, *) {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setInitialViewAsRootViewController()
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            slideMenuController()?.changeLeftViewWidth(self.view.frame.size.width * 0.89)
            SlideMenuOptions.contentViewScale = 1
            self.countLbl.layer.cornerRadius = self.countLbl.frame.size.height/2
        }
    }
    func playAnimation(){
        animationView = .init(name: "81860-car-and-skylines")
          animationView!.frame = emptyVehicleAnimation.bounds
          // 3. Set animation content mode
          animationView!.contentMode = .scaleAspectFill
          // 4. Set animation loop mode
          animationView!.loopMode = .loop
          // 5. Adjust animation speed
          animationView!.animationSpeed = 0.5
        emptyVehicleAnimation.addSubview(animationView!)
          // 6. Play animation
          animationView!.play()
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
    @IBAction func menuBtn(_ sender: Any) {
        self.openLeft()
    }
    
    @IBAction func viewMoreBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func salesBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
            vc.categoryId = 1
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func bodyShopBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
            vc.categoryId = 2
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func serviceBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
            vc.categoryId = 3
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func insuranceBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
            vc.categoryId = 4
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func notificationBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_NotificationVC") as! DD_NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func bannerImageApi(){
    let parameter = [
        "ObjImageGallery": [
        "AlbumCategoryID": "1"
            ]
    ] as [String: Any]
        print(parameter)
        self.dashboardBannerImageApi(parameter: parameter)
    }
    func dashboardApi(){
        let parameter = [
            "ActorId":"\(self.userID)"
        ] as [String: Any]
        print(parameter)
        self.VM.dashBoardApi(parameter: parameter)
    }
    func userStatusApi(){
        let parameter = [
            "ActorId":"\(self.userID)"
        ] as [String: Any]
        print(parameter)
        self.VM.userActiveApi(parameter: parameter)
    }
    
    func dashboardVehicleListApi(loyaltyID: String){
        let parameter = [
            "ActionType": "261",
            "ActorId":"\(self.userID)",
            "LoyaltyID":loyaltyID
        ] as [String: Any]
        print(parameter)
        self.VM.dashBoardApiVehicleApi(parameter: parameter)
        
    }
    
    func ImageSetups(){
        self.VM.sourceArray.removeAll()
        if self.bannerImagesArray.count > 0 {
            for image in self.bannerImagesArray {
                    print(image.imageGalleryUrl,"ImageURL")
                    let filterImage = (image.imageGalleryUrl ?? "").dropFirst(2)
                    let images = ("\(PROMO_IMG1)\(filterImage)").replacingOccurrences(of: " ", with: "%20")
                    
                self.VM.sourceArray.append(AlamofireSource(urlString: images, placeholder: UIImage(named: "ic_default_img"))!)
                    
                }
            bannerImageSlideShow.setImageInputs(self.VM.sourceArray)
            bannerImageSlideShow.slideshowInterval = 3.0
            bannerImageSlideShow.zoomEnabled = true
            bannerImageSlideShow.contentScaleMode = .scaleToFill
            } else {
                self.emptyBannerImage.isHidden = false
            }
        }
    func dashboardBannerImageApi(parameter: JSON){
        self.startLoading()
        self.bannerImagesArray.removeAll()
        
        self.requestAPIs.dashboardBannerImageListApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.stopLoading()
                        self.loaderView.isHidden = true
                        self.bannerImagesArray = result?.objImageGalleryList ?? []
                        print(self.bannerImagesArray.count, "Banner Image Array Count")
                        if self.bannerImagesArray.count != 0 {
                            self.ImageSetups()
                            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
                            self.bannerImageSlideShow.addGestureRecognizer(gestureRecognizer)
                            self.bannerImageSlideShow.isHidden = false
                            self.emptyBannerImage.isHidden = true
                            
                        }else{
                            self.emptyBannerImage.isHidden = false
                        }
                      
                    }
                }else{
                    DispatchQueue.main.async {
                    self.stopLoading()
                        self.loaderView.isHidden = true
                    }
                }
            }else{
                DispatchQueue.main.async {
                self.stopLoading()
                    self.loaderView.isHidden = true
                }
            }
        }
    }
    
    
    func playAnimationMaintanace(){
        animationView = .init(name: "27592-maintenance")
        animationView!.frame = underMaintenance.bounds
          // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
          // 4. Set animation loop mode
        animationView!.loopMode = .loop
          // 5. Adjust animation speed
        animationView!.animationSpeed = 1
        underMaintenance.addSubview(animationView!)
          // 6. Play animation
        animationView!.play()

    }
    
    func isUpdateAvailable() {
        let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        print(bundleId)
        Alamofire.request("https://itunes.apple.com/in/lookup?bundleId=\(bundleId)").responseJSON { response in
            if let json = response.result.value as? NSDictionary, let results = json["results"] as? NSArray, let entry = results.firstObject as? NSDictionary, let appStoreVersion = entry["version"] as? String,let appstoreid = entry["trackId"], let trackUrl = entry["trackViewUrl"], let installedVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                let installed = Int(installedVersion.replacingOccurrences(of: ".", with: "")) ?? 0
                print(installed)
                let appStore = Int(appStoreVersion.replacingOccurrences(of: ".", with: "")) ?? 0
                print(appStore)
                print(appstoreid)
                if appStore>installed {
                        let alertController = UIAlertController(title: "New update Available!", message: "Update is available to download. Downloading the latest update you will get the latest features, improvements and bug fixes of DD Motors Connect App", preferredStyle: .alert)

                        // Create the actions
                        let okAction = UIAlertAction(title: "Update Now", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.openURL(NSURL(string: "\(trackUrl)")! as URL)

                        }
                        //                     Add the actions
                        alertController.addAction(okAction)
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)

                }else{
                    print("no updates")

                }
            }
        }
    }
    
    func maintenanceAPI(){
        guard let url = URL(string: "http://appupdate.arokiait.com/updates/serviceget?pid=com.loyaltyWorks.DD-MotorsService") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:dataResponse, options: [])
                print(jsonResponse)
                let isMaintenanceValue = ((jsonResponse as AnyObject).value(forKeyPath: "Result.is_maintenance") as? String)
                let forceupdatevalue = ((jsonResponse as AnyObject).value(forKeyPath: "Result.version_number") as? String)
                print(forceupdatevalue)
                if isMaintenanceValue == "1"{
                    print(isMaintenanceValue)
                    DispatchQueue.main.async {
                        self.maintenanceView.isHidden = false
                        self.playAnimationMaintanace()
                        self.tabBarController?.tabBar.isHidden = true

                    }
                }else if isMaintenanceValue == "0"{
                    DispatchQueue.main.async {
                        self.tokendata()
                        self.animationView?.stop()
                        self.tabBarController?.tabBar.isHidden = false
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    
    
    
    
    @objc func didTap() {
        if self.bannerImagesArray.count > 0 {
            
            self.bannerImageSlideShow.presentFullScreenController(from: self)
        }
    }
    func tokendata(){
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            }else{
                let parameters : Data = "username=\(username)&password=\(password)&grant_type=password".data(using: .utf8)!

            let url = URL(string: tokenURL)!
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            do {
                request.httpBody = parameters
            } catch let error {
                print(error.localizedDescription)
            }
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
           
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do{
                    let parseddata = try JSONDecoder().decode(TokenModels.self, from: data)
                        print(parseddata.access_token ?? "")
                        UserDefaults.standard.setValue(parseddata.access_token ?? "", forKey: "TOKEN")
                    DispatchQueue.main.async {
                        if self.bannerImageCalled == 1{
//                            self.bannerImageApi()
                            self.notificationListApi()
                            self.bannerImageCalled = 0
                        }
                        self.userStatusApi()
                    //    self.dashboardApi()
                        
                    }
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
        }
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
                    self.countLbl.isHidden = false
                    self.countLbl.text = ""
//                    self.countLbl.text = "\(self.VM.notificationListArray.count )"
                }
            }else{
                self.countLbl.isHidden = true
            }
        }
        
    }
    
    
    
    
    
    
    
}
extension DD_DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.VM.vehicleListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DD_MyVehicleCVC", for: indexPath) as! DD_MyVehicleCVC
//        @IBOutlet weak var vehicleColorLbl: UILabel!
//        @IBOutlet weak var vehicleNamelbl: UILabel!
//        @IBOutlet weak var vehicleCompanyLbl: UILabel!
//        @IBOutlet weak var subView: UIView!
//        @IBOutlet weak var vehicleImage: UIImageView!
        cell.vehicleColorLbl.text = self.VM.vehicleListArray[indexPath.row].colorName ?? ""
        cell.vehicleNamelbl.text = self.VM.vehicleListArray[indexPath.row].productCode ?? ""
        cell.vehicleCompanyLbl.text = self.VM.vehicleListArray[indexPath.row].categoryName ?? ""
        print(self.VM.vehicleListArray[indexPath.row].imageUrl ?? "", "asdfsadfasfasdfdsa")
        if self.VM.vehicleListArray[indexPath.row].imageUrl ?? "" != ""{
            
            let receivedImagePath = URL(string: "\(PROMO_IMG1)\(self.VM.vehicleListArray[indexPath.row].imageUrl?.dropFirst(2) ?? "")")
            //cell.vehicleImage.kf.setImage(with: receivedImagePath)
//            cell.vehicleImage.kf.setImage(with: URL(string: "\(String(describing: receivedImagePath))"), placeholder: UIImage(named: "Group 7229"))
            cell.vehicleImage.sd_setImage(with: receivedImagePath!, placeholderImage: UIImage(named: "Group 7229"))
        }else{
            cell.vehicleImage.image = UIImage(named: "Group 7229")
        }
        
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let height = collectionView.frame.height
//
//        return CGSize(width: 175, height: height)
//    }
}
