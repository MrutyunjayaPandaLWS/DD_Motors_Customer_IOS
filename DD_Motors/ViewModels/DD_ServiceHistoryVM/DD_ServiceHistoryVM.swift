//
//  DD_ServiceHistoryVM.swift
//  DD_Motors
//
//  Created by ADMIN on 16/01/2023.
//


import Foundation
import Toast_Swift

class DD_ServiceHistoryVM {
    
    weak var VC: DD_Service_HistoryVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var serviceHistoryListingArray = [LstUserVehicleDetails1]()
    func serviceHistoryListApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
         self.VC?.playAnimation2()
        self.requestAPIs.serviceHistoryApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.serviceHistoryListingArray.removeAll()
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        self.serviceHistoryListingArray = result?.lstUserVehicleDetails ?? []
                        if self.serviceHistoryListingArray.count != 0 {
                            self.VC?.serviceHistoryTableView.isHidden = false
                            self.VC?.noDataFoundLbl.isHidden = true
                            self.VC?.serviceHistoryTableView.reloadData()
                        }else{
                            self.VC?.serviceHistoryTableView.isHidden = true
//                            self.VC?.view.makeToast("No data found !!", duration: 3.0, position: .center)
                            self.VC?.noDataFoundLbl.isHidden = false
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
