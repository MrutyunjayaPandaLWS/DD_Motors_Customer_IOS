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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myOffersListAPI(categoryId: self.categoryId)
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
        self.navigationController?.pushViewController(vc, animated: true)
       }

    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func myOffersListAPI(categoryId: Int){
        let parameter = [
            "ActionType": "46",
            "ActorId": "\(self.userID)",
            "LoyaltyId":"\(self.loyaltyId)",
            "OfferTypeID": categoryId
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
            if self.VM.myOffersListArray[tappedIndexPath.row].subscriptionStatus ?? "0" == "1" && self.VM.myOffersListArray[tappedIndexPath.row].is_Gifited ?? 0 == 1{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_MyOffersDetailsVC") as! DD_MyOffersDetailsVC
                vc.cardNumber = Int(self.VM.myOffersListArray[tappedIndexPath.row].cardNumber ?? "") ?? 0
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
            return self.VM.myOffersListArray.count
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
            
            cell.cartNumberLbl.text = "Offer ID \(self.VM.myOffersListArray[indexPath.row].cardNumber ?? "")"
            cell.offersTitleLbl.text = self.VM.myOffersListArray[indexPath.row].giftCardTypeName ?? ""
            cell.expiredLbl.text = "Expired"
            cell.expiredLbl.textColor = UIColor.red
            cell.detailsBtb.tag = indexPath.row
            if self.VM.myOffersListArray[indexPath.row].subscriptionStatus ?? "0" == "1"{
                cell.scratchView.isHidden = false
                if self.VM.myOffersListArray[indexPath.row].is_Gifited ?? 0 == 0{
                    cell.enableOfferImage.isHidden = false
                    for data in self.unlockedImageArray{
                        if data == "EnableRed" || data == "EnableBlue" || data == "EnableBlue 1" || data == "EnableRed 1"{
                            cell.enableOfferImage.image = UIImage(named: "\(self.unlockedImageArray[indexPath.row])")
                        }
                    }
                 
                }else{
                    cell.enableOfferImage.isHidden = true
                    
                }
                
                cell.lockerView.isHidden = true
                if self.VM.myOffersListArray[indexPath.row].expiry ?? -1 == 1{
                    cell.expiredLbl.isHidden = false
                    cell.bottomSpaceConstraint.constant = 26
                }else{
                    cell.expiredLbl.isHidden = true
                    cell.bottomSpaceConstraint.constant = 5
                    
                }
            }else{
                cell.scratchView.isHidden = true
                cell.lockerView.isHidden = false
                    for data in self.unlockedImageArray{
                        if data == "LockedRed" || data == "LockedBlue" || data == "LockedRed 1" || data == "LockedBlue 1"{
                            cell.lockedImage.image = UIImage(named: "\(self.unlockedImageArray[indexPath.row])")
                        }
                    }
              
            }
            
          
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myOffersListCollectionView{
            if self.VM.myOffersListArray[indexPath.row].subscriptionStatus ?? "0" != "1"{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SubscribePopUp") as! DD_SubscribePopUp
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }else if self.VM.myOffersListArray[indexPath.row].subscriptionStatus ?? "0" == "1" && self.VM.myOffersListArray[indexPath.row].is_Gifited ?? 0 == 0{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_SuccessPopUp") as! DD_SuccessPopUp
                vc.cardNumber = self.VM.myOffersListArray[indexPath.row].cardNumber ?? ""
                vc.offerReferenceID = self.VM.myOffersListArray[indexPath.row].offerReferenceID ?? ""
                vc.isGiftID = self.VM.myOffersListArray[indexPath.row].is_Gifited ?? 0
                self.cardNumber = Int(self.VM.myOffersListArray[indexPath.row].cardNumber ?? "") ?? 0
                self.offersID = self.VM.myOffersListArray[indexPath.row].offerReferenceID ?? ""
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
         
        }else{
            self.categoryId = self.VM.myOffersCategoryListArray[indexPath.row].attributeId ?? -1
            self.myOffersCategoryApi()
            self.myOffersListAPI(categoryId: self.categoryId)
            
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
