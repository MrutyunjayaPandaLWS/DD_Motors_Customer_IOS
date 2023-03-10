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
        self.myOffersListArray1.removeAll()
        self.myOffersListArray.removeAll()
        self.VC?.unlockedImageArray.removeAll()
        self.VC?.lockedImageArray.removeAll()
        self.myOffersListArray.removeAll()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.requestAPIs.myOffersListApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        self.myOffersListArray = result?.lstGiftCardType ?? []
                        self.myOffersListArray1.removeAll()
                        print(self.myOffersListArray1.count, "Total Count")
                        if self.myOffersListArray.count != 0 {
                            for data in self.myOffersListArray{
                                if self.myOffersListArray.count >= 4{
                                    if data.subscriptionStatus ?? "0" == "1" && data.is_Gifited ?? 0 == 0{
                                        if self.unlockedImg == "1"{
                                            self.VC?.unlockedImageArray.append("EnableOfferBlue")
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferBlue", offerReferenceID: data.offerReferenceID ?? ""))
                                            self.unlockedImg = "2"
                                        }else if self.unlockedImg == "2"{
                                            self.VC?.unlockedImageArray.append("EnableOfferRed")
                                            self.unlockedImg = "3"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferRed", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.unlockedImg == "3"{
                                            self.unlockedImg = "4"
                                            self.VC?.unlockedImageArray.append("EnableOfferRed1")
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferRed1", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.unlockedImg == "4"{
                                            self.unlockedImg = "1"
                                            self.VC?.unlockedImageArray.append("EnableOfferBlue1")
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferBlue1", offerReferenceID: data.offerReferenceID ?? ""))
                                        }
                                    }else{
                                        if self.lockedImage == "5"{
                                            self.VC?.unlockedImageArray.append("LockedBlue")
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedBlue", offerReferenceID: data.offerReferenceID ?? ""))
                                            self.lockedImage = "6"
                                        }else if self.lockedImage == "6"{
                                            self.VC?.unlockedImageArray.append("LockedRed")
                                            self.lockedImage = "7"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedRed", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.lockedImage == "7"{
                                            self.lockedImage = "8"
                                            self.VC?.unlockedImageArray.append("LockedRed 1")
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedRed 1", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.lockedImage == "8"{
                                            self.lockedImage = "5"
                                            self.VC?.unlockedImageArray.append("LockedBlue 1")
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedBlue 1", offerReferenceID: data.offerReferenceID ?? ""))
                                        }
                                    }
                                }else if self.myOffersListArray.count == 3{
                                    if data.subscriptionStatus ?? "0" == "1" && data.is_Gifited ?? 0 == 0{
                                        if self.unlockedImg == "1"{
                                            self.VC?.unlockedImageArray.append("EnableOfferBlue")
                                            self.unlockedImg = "2"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferBlue", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.unlockedImg == "2"{
                                            self.VC?.unlockedImageArray.append("EnableOfferRed")
                                            self.unlockedImg = "3"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferRed", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.unlockedImg == "3"{
                                            self.unlockedImg = "1"
                                            self.VC?.unlockedImageArray.append("EnableOfferRed1")
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferRed1", offerReferenceID: data.offerReferenceID ?? ""))
                                        }
                                    }else{
                                        if self.lockedImage == "5"{
                                            self.VC?.unlockedImageArray.append("LockedBlue")
                                            self.lockedImage = "6"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedBlue", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.lockedImage == "6"{
                                            self.VC?.unlockedImageArray.append("LockedRed")
                                            self.lockedImage = "7"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedRed", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.lockedImage == "7"{
                                            self.lockedImage = "5"
                                            self.VC?.unlockedImageArray.append("LockedRed 1")
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedRed 1", offerReferenceID: data.offerReferenceID ?? ""))
                                        }
                                    }
                                }else if self.myOffersListArray.count == 2{
                                    if data.subscriptionStatus ?? "0" == "1" && data.is_Gifited ?? 0 == 0{
                                        if self.unlockedImg == "1"{
                                            self.VC?.unlockedImageArray.append("EnableOfferBlue")
                                            self.unlockedImg = "2"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferBlue", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.unlockedImg == "2"{
                                            self.VC?.unlockedImageArray.append("EnableOfferRed")
                                            self.unlockedImg = "1"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferRed", offerReferenceID: data.offerReferenceID ?? ""))
                                        }
                                    }else{
                                        if self.lockedImage == "5"{
                                            self.VC?.unlockedImageArray.append("LockedBlue")
                                            self.lockedImage = "6"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedBlue", offerReferenceID: data.offerReferenceID ?? ""))
                                        }else if self.lockedImage == "6"{
                                            self.VC?.unlockedImageArray.append("LockedRed")
                                            self.lockedImage = "5"
                                            self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedRed", offerReferenceID: data.offerReferenceID ?? ""))
                                        }
                                    }
                                }else if self.myOffersListArray.count == 1{
                                    if data.subscriptionStatus ?? "0" == "1" && data.is_Gifited ?? 0 == 0{
                                        
                                        self.VC?.unlockedImageArray.append("EnableOfferBlue")
                                        self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "EnableOfferBlue", offerReferenceID: data.offerReferenceID ?? ""))
                                        
                                    }else{
                                        self.VC?.unlockedImageArray.append("LockedBlue")
                                        self.myOffersListArray1.append(MyOffersModels(cardNumber: data.cardNumber ?? "", giftCardTypeName: data.giftCardTypeName ?? "", subscriptionStatus: data.subscriptionStatus ?? "", is_Gifited: data.is_Gifited ?? 0, expiry:data.expiry ?? 0, offerImage:  "LockedBlue", offerReferenceID: data.offerReferenceID ?? ""))
                                    }
                                }
                            }
                            self.VC?.myOffersListCollectionView.isHidden = false
                            
                        }else{
                            self.VC?.myOffersListCollectionView.isHidden = true
                            self.VC?.view.makeToast("No data found !!", duration: 1.0, position: .bottom)
                        }
                        print(self.VC?.unlockedImageArray.count)
                        self.VC?.myOffersListCollectionView.reloadData()
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
    
    func myOffersCategoryList(parameter: JSON){
        self.myOffersCategoryListArray.removeAll()
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.requestAPIs.myOffersCategoryListApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                    
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        self.myOffersCategoryListArray.append(MyCategoryListModels(attributeId: -1, attributeValue: "All", attributeType: "OFFER_REDEEMED_TYPE"))
                        for data in result?.lstAttributesDetails ?? []{
                            if data.attributeType ?? "" == "OFFER_REDEEMED_TYPE"{
                                self.myOffersCategoryListArray.append(MyCategoryListModels(attributeId: data.attributeId ?? 0, attributeValue: data.attributeValue ?? "", attributeType: data.attributeType ?? ""))
                            }
                        }
                        
                        if self.myOffersCategoryListArray.count != 0 {
                            self.VC?.categoryCollectionView.isHidden = false
                            self.VC?.categoryCollectionView.reloadData()
                        }else{
                            self.VC?.categoryCollectionView.isHidden = true
                            self.VC?.view.makeToast("No data found !!", duration: 1.0, position: .bottom)
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

