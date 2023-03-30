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
    
    @IBOutlet weak var myOffersListCollectionView: UICollectionView!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
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
    
    var noofelements = 0
    var startIndex = 1
    var itsEnable = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.VM.VC = self
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
      
        self.myOffersListAPI(categoryId: self.categoryId, startIndex: 1)
        self.myOffersCategoryApi()
    }
    @objc func moveToSubscribe(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscriptionVC") as! DD_SubscriptionVC
        vc.itsFrom = "SideMenu"
        self.navigationController?.pushViewController(vc, animated: true)
       }
    
    @objc func moveToDetails(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersDetailsVC") as! DD_MyOffersDetailsVC
        vc.itsFrom = "SideMenu"
        vc.cardNumber = Int(self.cardNumber)
        vc.categoryId = self.categoryId
        vc.offerId = "\(self.offersID)"
        self.navigationController?.pushViewController(vc, animated: true)
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
            "PageSize": 10
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
            if self.VM.myOffersListArray1[tappedIndexPath.row].subscriptionStatus ?? "0" == "1" && self.VM.myOffersListArray1[tappedIndexPath.row].is_Gifited ?? 0 == 1{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersDetailsVC") as! DD_MyOffersDetailsVC
                vc.cardNumber = Int(self.VM.myOffersListArray1[tappedIndexPath.row].cardNumber ?? "") ?? 0
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
            if self.categoryId == self.VM.myOffersCategoryListArray[indexPath.row].attributeId ?? 0 {
                
                cell.categoryLbl.textColor = UIColor.white
                cell.subView.backgroundColor = #colorLiteral(red: 0.07028683275, green: 0.4640961289, blue: 0.9083878398, alpha: 1)
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
            print(redeemedStatus[1])
                if  "\(subscriptionStatus)" == "1"{
                    cell.scratchView.isHidden = false
                    if self.VM.myOffersListArray1[indexPath.row].is_Gifited ?? 0 == 0{
                     //   if self.VM.myOffersListArray1[indexPath.row].offerImage ?? "" == "EnableOfferBlue" || self.VM.myOffersListArray1[indexPath.row].offerImage ?? "" == "EnableOfferBlue1"{
                        if self.itsEnable == 1{
                            self.itsEnable = 0
                            cell.enableBlueImage.isHidden = true
                            cell.enableRedImage.isHidden = false
                            cell.lockedBlueImage.isHidden = true
                            cell.lockedRedImage.isHidden = true
                        }else{
                            self.itsEnable = 1
                            cell.enableBlueImage.isHidden = false
                            cell.enableRedImage.isHidden = true
                            cell.lockedBlueImage.isHidden = true
                            cell.lockedRedImage.isHidden = true
                        }
                       // }
//                        else{
//                            cell.enableBlueImage.isHidden = true
//                            cell.enableRedImage.isHidden = false
//                        }
                        
                        
                    }else{
//                        if self.VM.myOffersListArray1[indexPath.row].offerImage ?? "" != "EnableOfferRed" || self.VM.myOffersListArray1[indexPath.row].offerImage ?? "" != "EnableOfferBlue" || self.VM.myOffersListArray1[indexPath.row].offerImage ?? "" != "EnableOfferBlue1" || self.VM.myOffersListArray1[indexPath.row].offerImage ?? "" != "EnableOfferRed1"{
//
                            cell.scratchView.borderWidth = 1
                            cell.scratchView.borderColor = .red
//                        }
                        cell.enableRedImage.isHidden = true
                        cell.enableBlueImage.isHidden = true
                        
                    }
                    cell.lockerView.isHidden = true
                    if self.VM.myOffersListArray1[indexPath.row].expiry ?? -1 == 1 && "\(redeemedStatus[1])" == "1"{
                        cell.expiredLbl.isHidden = false
                        cell.expiredLbl.text = "Expired"
                        cell.bottomSpaceConstraint.constant = 26
                    }else if self.VM.myOffersListArray1[indexPath.row].expiry ?? -1 == 0 && "\(redeemedStatus[1])" == "0"{
                        cell.expiredLbl.isHidden = true
                        cell.expiredLbl.text = ""
                        cell.bottomSpaceConstraint.constant = 6
                    }else{
                        cell.expiredLbl.isHidden = false
                        cell.expiredLbl.text = "Redeemed"
                        cell.expiredLbl.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                        cell.expiredLbl.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                        cell.bottomSpaceConstraint.constant = 26
                        
                    }
                }else{
                    cell.scratchView.isHidden = true
                    cell.lockerView.isHidden = false
                    
//                    cell.lockedBlueImage.isHidden = false
//                    cell.lockedRedImage.isHidden = true
                    //if self.VM.myOffersListArray1[indexPath.row].offerImage ?? "" == "LockedBlue" || self.VM.myOffersListArray1[indexPath.row].offerImage ?? "" == "LockedBlue 1"{
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
                   // }
//                    else{
//                        cell.lockedBlueImage.isHidden = true
//                        cell.lockedRedImage.isHidden = false
//                    }
                }
         
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == myOffersListCollectionView{
            let subscriptionStatus = String(self.VM.myOffersListArray1[indexPath.row].subscriptionStatus ??  "0").prefix(1)
            print(subscriptionStatus)
            if "\(subscriptionStatus)" == "1"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SuccessPopUp") as! DD_SuccessPopUp
                vc.cardNumber = self.VM.myOffersListArray1[indexPath.row].cardNumber ?? ""
                vc.offerReferenceID = self.VM.myOffersListArray1[indexPath.row].offerReferenceID ?? ""
                vc.isGiftID = self.VM.myOffersListArray1[indexPath.row].is_Gifited ?? 0
                vc.offerTitle = self.VM.myOffersListArray1[indexPath.row].giftCardTypeName ?? ""
                self.cardNumber = Int(self.VM.myOffersListArray1[indexPath.row].cardNumber ?? "") ?? 0
                self.offersID = self.VM.myOffersListArray1[indexPath.row].offerReferenceID ?? ""
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }else{
               
                    let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscribePopUp") as! DD_SubscribePopUp
                    vc.selectedImage = "\(self.VM.myOffersListArray1[indexPath.row].offerImage ?? "")"
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
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == myOffersListCollectionView{
            if indexPath.row == self.VM.myOffersCategoryListArray.count - 1{
                if self.noofelements == 10{
                    self.startIndex = self.startIndex + 1
                    self.myOffersListAPI(categoryId: self.categoryId, startIndex: self.startIndex)
                }else if self.noofelements > 10{
                    self.startIndex = self.startIndex + 1
                    self.myOffersListAPI(categoryId: self.categoryId, startIndex: self.startIndex)
                }else if self.noofelements < 10{
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
