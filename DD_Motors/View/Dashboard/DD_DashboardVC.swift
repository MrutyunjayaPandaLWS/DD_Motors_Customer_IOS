//
//  DD_DashboardVC.swift
//  DD_Motors
//
//  Created by ADMIN on 22/12/2022.
//

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
    private var animationView: LottieAnimationView?
    private var loaderAnimationView : LottieAnimationView?
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var VM = DD_DashBoardVM()
    var requestAPIs = RestAPI_Requests()
    var sourceArray = [AlamofireSource]()
    var bannerImagesArray = [ObjImageGalleryList1]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.bannerImageApi()
     
        myVehicleCollectionView.delegate = self
        myVehicleCollectionView.dataSource = self

        let collectionViewFLowLayout = UICollectionViewFlowLayout()
        
        collectionViewFLowLayout.itemSize = CGSize(width: (self.view.bounds.width - 10 - (self.myVehicleCollectionView.contentInset.left + self.myVehicleCollectionView.contentInset.right)) / 2, height: 210)
        collectionViewFLowLayout.minimumLineSpacing = 2.5
        collectionViewFLowLayout.minimumInteritemSpacing = 2.5
        collectionViewFLowLayout.scrollDirection = .horizontal
        self.myVehicleCollectionView.collectionViewLayout = collectionViewFLowLayout
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.slideMenuController()?.closeLeft()
        self.loaderView.isHidden = false
        self.playAnimation2()
        self.tokendata()
        
    }
    
    override func viewDidLayoutSubviews() {
        slideMenuController()?.changeLeftViewWidth(self.view.frame.size.width * 0.89)
        SlideMenuOptions.contentViewScale = 1
        self.countLbl.layer.cornerRadius = self.countLbl.frame.size.height/2
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
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func salesBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
        vc.categoryId = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bodyShopBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
        vc.categoryId = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func serviceBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
        vc.categoryId = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func insuranceBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersVC") as! DD_MyOffersVC
        vc.categoryId = 4
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func notificationBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_NotificationVC") as! DD_NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func dashboardVehicleListApi(){
        let parameter = [
            "ActionType": "261",
            "ActorId":"\(self.userID)",
            "LoyaltyID":"\(UserDefaults.standard.string(forKey: "LoyaltyId") ?? "")"
        ] as [String: Any]
        print(parameter)
        self.VM.dashBoardApiVehicleApi(parameter: parameter)
        
    }
    
    func ImageSetups(){
        self.sourceArray.removeAll()
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
                        self.dashboardApi()
                        
                    }
                     }catch let parsingError {
                    print("Error", parsingError)
                }
            })
            task.resume()
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
            let receivedImagePath = URL(string: "\(imageBaseURL)\(self.VM.vehicleListArray[indexPath.row].imageUrl ?? "")")
            cell.vehicleImage.kf.setImage(with: receivedImagePath)
        }else{
            cell.vehicleImage.image = UIImage(named: "swift-sport-black-and-red")
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
