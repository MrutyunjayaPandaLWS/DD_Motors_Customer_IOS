//
//  DD_MyOffersVM.swift
//  DD_Motors
//
//  Created by ADMIN on 11/01/2023.
//

import Foundation
import Toast_Swift

class DD_MyOffersVM {
    
    weak var VC: DD_MyOffersVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var myOffersListArray = [LstGiftCardType]()
//    let lstAttributesDetails : [LstAttributesDetails21]?
//    var myOffersCategoryListArray = [LstAttributesDetails21]()
    var myOffersCategoryListArray = [MyCategoryListModels]()
    var myOffersListArray1 = [MyOffersModels]()
    var lockedImg = "5"
    var unlockedImage = "1"
    var unlockedImg = "1"
    var lockedImage = "5"
    
    func myOffersListApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.unlockedImageArray.removeAll()
        self.VC?.lockedImageArray.removeAll()
        self.VC?.loaderView.isHidden = false
        self.VC?.noOffersAnimationView.isHidden = true
        self.VC?.playAnimation2()
        self.myOffersListArray1.removeAll()
        self.myOffersListArray.removeAll()
        
        self.requestAPIs.myOffersListApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        //self.myOffersListArray = result?.lstGiftCardType ?? []
                        let myOfferListsArray = result?.lstGiftCardType ?? []
                        self.myOffersListArray += myOfferListsArray
                        self.VC?.noofelements = self.myOffersListArray.count
                        print(self.myOffersListArray.count, "Total Count")
                        if myOfferListsArray.isEmpty == false{
                            for data in self.myOffersListArray{
                                let subscribeData = data.subscriptionStatus?.suffix(1)
                                
                                if subscribeData == "1" && data.is_Gifited ?? 0 == 0{
                                    if data.expiry != 1{
                                        self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "", offerReferenceID: data.offerReferenceID ?? "", cardImagePath: data.cardImagePath ?? ""))
                                    }else{
                                        debugPrint("Expiry is ",data.expiry)
                                    }
                                    
                                }else{

                                    if data.expiry != 1 && data.is_Gifited ?? 0 != 0{
                                        self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "", offerReferenceID: data.offerReferenceID ?? "", cardImagePath: data.cardImagePath ?? ""))
                                    }else{
                                        if self.VC?.secondCatagoryArray == "Active"{
                                            if data.expiry != 1{
                                                self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "", offerReferenceID: data.offerReferenceID ?? "", cardImagePath: data.cardImagePath ?? ""))
                                            }
                                        }else{
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "", offerReferenceID: data.offerReferenceID ?? "", cardImagePath: data.cardImagePath ?? ""))
                                        }
////
                                    }
                                    
                                    
                                    
                                }
                                self.VC?.myOffersListCollectionView.isHidden = false
                                self.VC?.myOffersListCollectionView.reloadData()
                            }
                        }else{
                            if self.VC!.startIndex > 1{
                                self.VC?.startIndex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.myOffersListCollectionView.isHidden = true
                                if self.VC?.secondCatagoryArray == "Redeemed" {
                                    self.VC?.noOffersAnimationView.isHidden = false
                                    self.VC?.noDataOffersMessageLbl.text = "You have not redeemed any offer!"
                                }else if self.VC?.secondCatagoryArray == "Expired" {
                                    self.VC?.noOffersAnimationView.isHidden = false
                                    self.VC?.noDataOffersMessageLbl.text = "There is no expired offer for you."
                                }else{
                                    self.VC?.noOffersAnimationView.isHidden = false
                                    self.VC?.noDataOffersMessageLbl.text = "Exciting offers on the way!"
                                }
                                
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.noOffersAnimationView.isHidden = false
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
            }
        }
    }
    func myOffersCategoryList(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.myOffersCategoryListArray.removeAll()
        self.myOffersListArray.removeAll()
        self.requestAPIs.myOffersCategoryListApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                    
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
//                        self.myOffersCategoryListArray.append(MyCategoryListModels(attributeId: -1, attributeValue: "All", attributeType: "OFFER_REDEEMED_TYPE"))
                        self.myOffersCategoryListArray.append(MyCategoryListModels(attributeId: -1, attributeValue: "All", attributeType: "OFFER_EARNED_TYPE"))
//                        OFFER_EARNEND_TYPE
                        for data in result?.lstAttributesDetails ?? []{
//                            if data.attributeType ?? "" == "OFFER_REDEEMED_TYPE"{
                            if data.attributeType ?? "" == "OFFER_EARNED_TYPE"{
                                self.myOffersCategoryListArray.append(MyCategoryListModels(attributeId: data.attributeId ?? 0, attributeValue: data.attributeValue ?? "", attributeType: data.attributeType ?? ""))
                            }
                        }
                        
                        if self.myOffersCategoryListArray.count != 0 {
                            self.VC?.categoryCollectionView.isHidden = false
                            self.VC?.categoryCollectionView.reloadData()
                        }else{
                            self.VC?.categoryCollectionView.isHidden = true
//                            self.VC?.view.makeToast("No data found !!", duration: 1.0, position: .bottom)
                            self.VC?.noOffersAnimationView.isHidden = false
                        }
                        
//
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
            }
        }
    }
}

