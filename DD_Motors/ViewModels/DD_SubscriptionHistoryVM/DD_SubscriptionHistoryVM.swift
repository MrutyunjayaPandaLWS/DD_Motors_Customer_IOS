//
//  DD_SubscriptionHistoryVM.swift
//  DD_Motors
//
//  Created by ADMIN on 09/01/2023.
//


import Foundation
import Toast_Swift

class DD_SubscriptionHistoryVM {
    
    weak var VC: DD_SubscriptionHistoryVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var subscriptionHistoryListingArray = [LstcustomerSubscriptionSources]()
    
    func myCashPointListingApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.subscriptionHistoryListingArray.removeAll()
        self.requestAPIs.subscriptionHistoryListingApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        self.subscriptionHistoryListingArray = result?.lstcustomerSubscriptionSources ?? []
                        print(self.subscriptionHistoryListingArray.count)
                        if self.subscriptionHistoryListingArray.count != 0 {
                            self.VC?.subscriptionHistoryTV.reloadData()
                            self.VC?.subscriptionHistoryTV.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                        }else{
                            self.VC?.subscriptionHistoryTV.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        self.VC?.noDataFoundLbl.isHidden = false
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    self.VC?.loaderView.isHidden = true
                    self.VC?.noDataFoundLbl.isHidden = false
                }
            }
        }
    }
}
