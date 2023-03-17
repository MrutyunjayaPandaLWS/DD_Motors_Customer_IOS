//
//  DD_MyCashPointVM.swift
//  DD_Motors
//
//  Created by ADMIN on 06/01/2023.
//

import Foundation
import Toast_Swift

class DD_MyCashPointVM {
    
    weak var VC: DD_MyCashPointVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var myCashPointListingArray = [LstRewardTransJsonDetails]()
    
    func myCashPointListingApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
//        self.myCashPointListingArray.removeAll()
        self.requestAPIs.myCashPointListApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        let myCashPointList = result?.lstRewardTransJsonDetails ?? []
                        print(self.myCashPointListingArray.count)
                        if myCashPointList.count != 0 {
                            self.myCashPointListingArray += myCashPointList
                            self.VC?.noofelements = self.myCashPointListingArray.count
                            if self.myCashPointListingArray.count != 0{
                                self.VC!.totalAvaliablePts.text = "\(self.myCashPointListingArray[0].pointBalance ?? 0)"
                                self.VC!.totalEarningPts.text = "\(self.myCashPointListingArray[0].totalPointCredited ?? 0)"
                                self.VC!.totalRedeemedPts.text = "\(self.myCashPointListingArray[0].totalPointDebited ?? 0)"
                                self.VC!.walletTableView.isHidden = false
                                self.VC!.noDataFoundLbl.isHidden = true
                                self.VC!.walletTableView.reloadData()
                            }else{
                                self.VC?.walletTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                            }
                        }else{
                            if self.VC!.startindex > 1{
                                self.VC?.startindex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.walletTableView.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
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
                    self.VC?.loaderView.isHidden = true
                    self.VC?.stopLoading()
                }
            }
        }
    }
}
