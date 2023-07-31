//
//  DD_MyOffersVC.swift
//  DD_Motors
//
//  Created by ADMIN on 24/12/2022.
//

import UIKit
import Toast_Swift
import Lottie
import Kingfisher
class DD_MyOffersVC: BaseViewController, InfoDelegate {
  
 
    
    @IBOutlet weak var offersAnimation: LottieAnimationView!
    @IBOutlet weak var noOffersAnimationView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var category1CollectionView: UICollectionView!
    @IBOutlet weak var myOffersListCollectionView: UICollectionView!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    @IBOutlet weak var noDataOffersMessageLbl: UILabel!
    private var loaderAnimationView : LottieAnimationView?
    var unlockedImageArray = [String]()
    var lockedImageArray = [String]()
    
    
    var VM = DD_MyOffersVM()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyId") ?? ""
    var categoryId = -1
    var cardNumber = 0
    var offersID = ""
    var isGiftID = 0
    
    var statusId = -1
    var secondCatagoryArray = ""
    var noofelements = 0
    var startIndex = 1
    var itsEnable = 0
    var filterCategoryListingArray = ["All","Active","Redeemed","Expired"]
    var imageView = ""
    var imageView1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            self.VM.VC = self
            category1CollectionView.delegate = self
            category1CollectionView.dataSource = self
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
            myOffersListCollectionView.dataSource = self
            myOffersListCollectionView.delegate = self
            self.loaderView.isHidden = true
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: (self.view.bounds.width - 20 - (self.myOffersListCollectionView.contentInset.left + self.myOffersListCollectionView.contentInset.right)) / 2, height: 200)
            layout.minimumLineSpacing = 2.5
            layout.minimumInteritemSpacing = 2.5
            self.myOffersListCollectionView.collectionViewLayout = layout
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(moveToSubscribe), name: Notification.Name.navigateSubscription, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(moveToDetails), name: Notification.Name.navigateDetails, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(myOffersApi), name: Notification.Name.hitMyOffersApi, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(navigateFromPopUP), name: Notification.Name.navigateFromPopUP, object: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            noOffersAnimationView.isHidden = true
            playAnimation3()
            self.VM.myOffersCategoryListArray.removeAll()
            self.VM.myOffersListArray1.removeAll()
            self.myOffersCategoryApi()
            self.myOffersListAPI(categoryId: self.categoryId, startIndex: 1)
    }
    
    @objc func myOffersApi(){
        self.VM.myOffersListArray1.removeAll()
        self.VM.myOffersListArray.removeAll()
        self.myOffersListAPI(categoryId: self.categoryId, startIndex: 1)
        self.myOffersCategoryApi()
//        self.myOffersListCollectionView.reloadData()
    }
    
    @objc func navigateFromPopUP(){
        self.VM.myOffersListArray1.removeAll()
        self.VM.myOffersListArray.removeAll()
        self.myOffersListCollectionView.reloadData()
        self.myOffersListAPI(categoryId: self.categoryId, startIndex: 1)
        
    }
    
    @objc func moveToSubscribe(){
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscriptionVC") as! DD_SubscriptionVC
            vc.itsFrom = "SideMenu"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
       }
    
    @objc func moveToDetails(){
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersDetailsVC") as! DD_MyOffersDetailsVC
            vc.itsFrom = "SideMenu"
            print(self.cardNumber)
//            vc.cardNumber = Int(self.cardNumber)
            vc.categoryId = self.categoryId
            vc.offerId = "\(self.offersID)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
       }

    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func myOffersListAPI(categoryId: Int, startIndex: Int){
        let parameter = [
            "ActionType": "46",
            "ActorId": "\(self.userID)",
            "LoyaltyId":"\(self.loyaltyId)",
            "OfferTypeID": categoryId,
            "StartIndex": startIndex,
            "PageSize": 20,
            "StatusId": self.statusId
        ] as [String: Any]
        
        print(parameter)
        self.VM.myOffersListApi(parameter: parameter)
    }
    
    func myOffersCategoryApi(){
        let parameter = [
            "ActionType": "152"
        ] as [String: Any]
        print(parameter)
        self.VM.myOffersCategoryList(parameter: parameter)
    }
    
    func didTapButton(_ cell: DD_MyOffersCVC) {
        guard let tappedIndexPath = myOffersListCollectionView.indexPath(for: cell) else{return}
        
        if cell.detailsBtb.tag == tappedIndexPath.row{
            //print(self.VM.myOffersListArray1[tappedIndexPath.row].subscriptionStatus ?? "0")
            let subscribe = self.VM.myOffersListArray1[tappedIndexPath.row].subscriptionStatus.prefix(1)
            
            if subscribe == "1" && self.VM.myOffersListArray1[tappedIndexPath.row].is_Gifited ?? 0 == 1{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersDetailsVC") as! DD_MyOffersDetailsVC
                print(self.VM.myOffersListArray1.count)
                print(self.VM.myOffersListArray1[tappedIndexPath.row].cardNumber ?? "")
                let cardNumberData = Int(self.VM.myOffersListArray1[tappedIndexPath.row].cardNumber ?? "") ?? 0
                print(cardNumberData,"sjank")
//                vc.cardNumber = cardNumberData
                vc.offerId = self.VM.myOffersListArray1[tappedIndexPath.row].offerReferenceID ?? ""
                vc.categoryId = self.categoryId
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
}
extension DD_MyOffersVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return self.VM.myOffersCategoryListArray.count
        }else if collectionView == category1CollectionView{
            return self.filterCategoryListingArray.count
        }else{
            return self.VM.myOffersListArray1.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DD_CategoryCVC", for: indexPath) as! DD_CategoryCVC
            cell.categoryLbl.text = self.VM.myOffersCategoryListArray[indexPath.row].attributeValue ?? ""
            if self.VM.myOffersCategoryListArray[indexPath.row].attributeValue ?? "" == "All"{
               
                cell.categoryImage.image = UIImage(named: "badge")
            }else if self.VM.myOffersCategoryListArray[indexPath.row].attributeValue ?? "" == "Sales"{
               
                cell.categoryImage.image = UIImage(named: "Sales")
            }else if self.VM.myOffersCategoryListArray[indexPath.row].attributeValue ?? "" == "BodyShop"{
                
                cell.categoryImage.image = UIImage(named: "BodyShop")
            }else if self.VM.myOffersCategoryListArray[indexPath.row].attributeValue ?? "" == "Service"{
                
                cell.categoryImage.image = UIImage(named: "Service")
            }else if self.VM.myOffersCategoryListArray[indexPath.row].attributeValue ?? "" == "Insurance"{
                
                cell.categoryImage.image = UIImage(named: "Insurance")
            }
            print(self.VM.myOffersCategoryListArray[indexPath.row].attributeId ?? 0)
            if self.categoryId == self.VM.myOffersCategoryListArray[indexPath.row].attributeId ?? 0 {
                print(self.VM.myOffersCategoryListArray[indexPath.row].attributeId ?? 0)
                cell.categoryLbl.textColor = UIColor.white
                cell.subView.backgroundColor = #colorLiteral(red: 0.07028683275, green: 0.4640961289, blue: 0.9083878398, alpha: 1)
            }else{
                cell.categoryLbl.textColor = UIColor.black
                cell.subView.backgroundColor = #colorLiteral(red: 0.9613716006, green: 0.9806967378, blue: 0.9979247451, alpha: 1)
            }
            
            return cell
        }else if collectionView == category1CollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DD_Category1CVC", for: indexPath) as! DD_Category1CVC
            cell.categoryLbl.text = self.filterCategoryListingArray[indexPath.row]
            //    ALL = "-1"
            //Active = 1
            // redemed = 3
            //expired = 2
            if self.statusId == -1 {
                if indexPath.row == 0{
                    cell.categoryLbl.textColor = UIColor.white
                    cell.subView.backgroundColor = #colorLiteral(red: 0.07028683275, green: 0.4640961289, blue: 0.9083878398, alpha: 1)
                }else{
                    cell.categoryLbl.textColor = UIColor.black
                    cell.subView.backgroundColor = #colorLiteral(red: 0.9613716006, green: 0.9806967378, blue: 0.9979247451, alpha: 1)
                }
            }else if self.statusId == 1{
                if indexPath.row == 1{
                    cell.categoryLbl.textColor = UIColor.white
                    cell.subView.backgroundColor = #colorLiteral(red: 0.07028683275, green: 0.4640961289, blue: 0.9083878398, alpha: 1)
                }else{
                    cell.categoryLbl.textColor = UIColor.black
                    cell.subView.backgroundColor = #colorLiteral(red: 0.9613716006, green: 0.9806967378, blue: 0.9979247451, alpha: 1)
                }
            }else if self.statusId == 3{
                if indexPath.row == 2{
                    cell.categoryLbl.textColor = UIColor.white
                    cell.subView.backgroundColor = #colorLiteral(red: 0.07028683275, green: 0.4640961289, blue: 0.9083878398, alpha: 1)
                }else{
                    cell.categoryLbl.textColor = UIColor.black
                    cell.subView.backgroundColor = #colorLiteral(red: 0.9613716006, green: 0.9806967378, blue: 0.9979247451, alpha: 1)
                }
            }else if self.statusId == 2{
                if indexPath.row == 3{
                    cell.categoryLbl.textColor = UIColor.white
                    cell.subView.backgroundColor = #colorLiteral(red: 0.07028683275, green: 0.4640961289, blue: 0.9083878398, alpha: 1)
                }else{
                    cell.categoryLbl.textColor = UIColor.black
                    cell.subView.backgroundColor = #colorLiteral(red: 0.9613716006, green: 0.9806967378, blue: 0.9979247451, alpha: 1)
                }
            }else{
                cell.categoryLbl.textColor = UIColor.black
                cell.subView.backgroundColor = #colorLiteral(red: 0.9613716006, green: 0.9806967378, blue: 0.9979247451, alpha: 1)
            }
            
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DD_MyOffersCVC", for: indexPath) as! DD_MyOffersCVC
            cell.delegate = self
            
            cell.cartNumberLbl.text = "\(self.VM.myOffersListArray1[indexPath.row].cardNumber ?? "")"
            cell.offersTitleLbl.text = self.VM.myOffersListArray1[indexPath.row].giftCardTypeName ?? ""
            cell.expiredLbl.text = "Expired"
            cell.expiredLbl.textColor = UIColor.red
            cell.detailsBtb.tag = indexPath.row
            if self.VM.myOffersListArray1[indexPath.row].cardImagePath ?? "" != ""{
                let receivedImage = String(self.VM.myOffersListArray1[indexPath.row].cardImagePath ?? "").dropFirst(2)
                let receivedImagePath = URL(string: "\(PROMO_IMG1)\(receivedImage)")
                cell.offerImage.kf.setImage(with: receivedImagePath)
            }else{
                cell.offerImage.image = UIImage(named: "default_vehicle")
            }
            let subscriptionStatus = String(self.VM.myOffersListArray1[indexPath.row].subscriptionStatus ??  "0").prefix(1)
            print(subscriptionStatus)
            let redeemedStatus = String(self.VM.myOffersListArray1[indexPath.row].subscriptionStatus ??  "0").split(separator: "~")
            print(redeemedStatus,"jdhsdk")
            print(self.VM.myOffersListArray1[indexPath.row].expiry ?? 0,"ikuhuihggiu" )
            if  "\(subscriptionStatus)" == "1"{
                cell.scratchView.isHidden = false
                if self.VM.myOffersListArray1[indexPath.row].is_Gifited ?? 0 == 0{
                    if self.VM.myOffersListArray1[indexPath.row].expiry != 1 {
                        if self.itsEnable == 1{
                            self.itsEnable = 0
                            cell.enableBlueImage.isHidden = true
                            cell.enableRedImage.isHidden = false
                            cell.lockedBlueImage.isHidden = true
                            cell.lockedRedImage.isHidden = true
                            cell.enableRedImage.image = UIImage(named: "EnableRed")
                        }else{
                            self.itsEnable = 1
                            cell.enableBlueImage.isHidden = false
                            cell.enableRedImage.isHidden = true
                            cell.lockedBlueImage.isHidden = true
                            cell.lockedRedImage.isHidden = true
                            cell.enableBlueImage.image = UIImage(named: "EnableBlue")
                        }
                    }else{
                        cell.enableBlueImage.isHidden = true
                        cell.enableRedImage.isHidden = false
                        cell.lockedBlueImage.isHidden = true
                        cell.lockedRedImage.isHidden = true
                        cell.enableRedImage.image = UIImage(named: "Group 7276")
                    
                    }
                    
                }else{
                    
                    cell.scratchView.borderWidth = 1
                    cell.scratchView.borderColor = .white
                    cell.enableRedImage.isHidden = true
                    cell.enableBlueImage.isHidden = true
                    
                }
                cell.lockerView.isHidden = true
                if "\(redeemedStatus[1])" == "1" {
                    cell.expiredLbl.isHidden = false
                    cell.expiredLbl.text = "Redeemed"
                    cell.expiredLbl.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                    cell.expiredLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                    cell.bottomSpaceConstraint.constant = 26
                }else{
                    
                    if self.VM.myOffersListArray1[indexPath.row].expiry ?? -1 == 1{
                        cell.expiredLbl.isHidden = false
                        cell.expiredLbl.text = "Expired"
                        cell.expiredLbl.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.1078313024)
                        cell.bottomSpaceConstraint.constant = 26
                    }else{
                        cell.expiredLbl.isHidden = true
                        cell.expiredLbl.text = ""
                        cell.bottomSpaceConstraint.constant = 6
                    }
                }
            }else{
                cell.scratchView.isHidden = true
                cell.lockerView.isHidden = false
                if self.itsEnable == 1{
                    self.itsEnable = 0
                    cell.lockedBlueImage.isHidden = true
                    cell.lockedRedImage.isHidden = false
                    cell.enableBlueImage.isHidden = true
                    cell.enableRedImage.isHidden = true
                }else{
                    self.itsEnable = 1
                    cell.lockedBlueImage.isHidden = false
                    cell.lockedRedImage.isHidden = true
                    cell.enableBlueImage.isHidden = true
                    cell.enableRedImage.isHidden = true
                }
                
            }
            
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == myOffersListCollectionView{
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
                let subscriptionStatus = String(self.VM.myOffersListArray1[indexPath.row].subscriptionStatus ?? "0").prefix(1)
                print(subscriptionStatus)
                if self.VM.myOffersListArray1[indexPath.row].expiry != 1 || self.VM.myOffersListArray1[indexPath.row].expiry == 1 && self.VM.myOffersListArray1[indexPath.row].is_Gifited == 1{
                    if "\(subscriptionStatus)" == "1"{
                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SuccessPopUp") as! DD_SuccessPopUp
                        vc.cardNumber = self.VM.myOffersListArray1[indexPath.row].cardNumber ?? ""
                        vc.offerReferenceID = self.VM.myOffersListArray1[indexPath.row].offerReferenceID ?? ""
                        vc.selcetedImage = "\(self.VM.myOffersListArray1[indexPath.row].cardImagePath ?? "")"
                        
                        if self.VM.myOffersListArray1[indexPath.row].expiry == 1 && self.VM.myOffersListArray1[indexPath.row].is_Gifited == 1{
                            vc.expiryData = 1
                        }else{
                            vc.expiryData = 0
                        }
                        let subscriptionStatus = String(self.VM.myOffersListArray1[indexPath.row].subscriptionStatus ?? "0").suffix(1)
                        if subscriptionStatus == "1" && self.VM.myOffersListArray1[indexPath.row].expiry == 0 && self.VM.myOffersListArray1[indexPath.row].is_Gifited == 1 || subscriptionStatus == "1" && self.VM.myOffersListArray1[indexPath.row].expiry == 2 && self.VM.myOffersListArray1[indexPath.row].is_Gifited == 1{
                            vc.redeemData = 1
                        }else if subscriptionStatus == "1" && self.VM.myOffersListArray1[indexPath.row].expiry == 0 && self.VM.myOffersListArray1[indexPath.row].is_Gifited == 1{
                            
                        }else{
                            vc.redeemData = 0
                        }
                        vc.sendImageView = "\(self.itsEnable)"
                        
                        vc.isGiftID = self.VM.myOffersListArray1[indexPath.row].is_Gifited ?? 0
                        vc.offerTitle = self.VM.myOffersListArray1[indexPath.row].giftCardTypeName ?? ""
                        self.cardNumber = Int(self.VM.myOffersListArray1[indexPath.row].cardNumber ?? "") ?? 0
                        UserDefaults.standard.set(self.VM.myOffersListArray1[indexPath.row].cardNumber ?? "", forKey: "CardNumber")
                        //UserDefaults.standard.set(self.VM.myOffersListArray1[indexPath.row].cardNumber ?? "", forKey: "CardNumber")
                        self.offersID = self.VM.myOffersListArray1[indexPath.row].offerReferenceID ?? ""
                        vc.modalTransitionStyle = .coverVertical
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true)
                    }else{
                        
                        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscribePopUp") as! DD_SubscribePopUp
                        print(self.VM.myOffersListArray1[indexPath.row].offerImage ?? "")
                        vc.selectedImage = "\(self.VM.myOffersListArray1[indexPath.row].cardImagePath ?? "")"
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true)
                    }
                }
            }
        }else if collectionView == categoryCollectionView {
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
                self.VM.myOffersListArray1.removeAll()
                self.categoryId = self.VM.myOffersCategoryListArray[indexPath.row].attributeId ?? -1
                self.myOffersCategoryApi()
                self.myOffersListAPI(categoryId: self.categoryId, startIndex: self.startIndex)
            }
            
        }else{
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                }
            }else{
                //    ALL = "-1"
                //Active = 1
                // redemed = 3
                //expired = 2
                self.VM.myOffersListArray1.removeAll()
                self.VM.myOffersListArray.removeAll()
                self.secondCatagoryArray = filterCategoryListingArray[indexPath.row]
                if secondCatagoryArray == "All" {
                    self.statusId = -1
                    self.category1CollectionView.reloadData()
                }else if secondCatagoryArray == "Active"{
                    self.statusId = 1
                    self.category1CollectionView.reloadData()
                }else if secondCatagoryArray == "Redeemed"{
                    self.statusId = 3
                    self.category1CollectionView.reloadData()
                }else if secondCatagoryArray == "Expired"{
                    self.statusId = 2
                    self.category1CollectionView.reloadData()
                }else{
                    self.statusId = -1
                    self.category1CollectionView.reloadData()
                }
                self.myOffersCategoryApi()
                self.myOffersListAPI(categoryId: self.categoryId, startIndex: self.startIndex)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == myOffersListCollectionView{
            if indexPath.row == self.VM.myOffersCategoryListArray.count - 1{
                if self.noofelements == 20{
                    self.startIndex = self.startIndex + 1
                    self.myOffersListAPI(categoryId: self.categoryId, startIndex: self.startIndex)
                }else if self.noofelements > 20{
                    self.startIndex = self.startIndex + 1
                    self.myOffersListAPI(categoryId: self.categoryId, startIndex: self.startIndex)
                }else if self.noofelements < 20{
                    print("no need to hit API")
                    return
                }else{
                    print("n0 more elements")
                    return
                }
            }
        }

    }
    

    
    func playAnimation3(){
            loaderAnimationView = .init(name: "94248-gift-blue")
            loaderAnimationView!.frame = offersAnimation.bounds
              // 3. Set animation content mode
            loaderAnimationView!.contentMode = .scaleAspectFill
              // 4. Set animation loop mode
            loaderAnimationView!.loopMode = .loop
              // 5. Adjust animation speed
            loaderAnimationView!.animationSpeed = 1.5
            offersAnimation.addSubview(loaderAnimationView!)
              // 6. Play animation
            loaderAnimationView!.play()
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
class MyCategoryListModels: NSObject{
    
    var attributeId: Int!
    var attributeValue: String!
    var attributeType: String!
    init(attributeId: Int!, attributeValue: String!, attributeType: String)
    {
        self.attributeType = attributeType
        self.attributeId = attributeId
        self.attributeValue = attributeValue
    }
}

class MyOffersModels: NSObject{
    
    var cardNumber: String!
    var giftCardTypeName: String!
    var subscriptionStatus: String!
    var is_Gifited: Int!
    var expiry: Int!
    var offerImage: String!
    var offerReferenceID: String!
    var cardImagePath: String!
    
    init(cardNumber:String!, giftCardTypeName: String!, subscriptionStatus: String!, is_Gifited: Int!, expiry: Int!, offerImage: String!, offerReferenceID: String!, cardImagePath: String){
        
        self.cardNumber = cardNumber
        self.giftCardTypeName = giftCardTypeName
        self.subscriptionStatus = subscriptionStatus
        self.is_Gifited = is_Gifited
        self.expiry = expiry
        self.offerImage = offerImage
        self.offerReferenceID = offerReferenceID
        self.cardImagePath = cardImagePath
    }
}
