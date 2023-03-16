//
//  DD_DealerShipLocationVM.swift
//  DD_Motors
//
//  Created by ADMIN on 05/01/2023.
//


import Foundation
import Toast_Swift

class DD_DealerShipLocationVM {
    
    weak var VC: DD_DealershipLocationVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var dealerShipListArray = [LstLocationDetails]()
    
    func dealerShipLocationAPi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.requestAPIs.dealerShipLocationApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        let dealerShipListArrya = result?.lstLocationDetails ?? []
                        
                        if dealerShipListArrya.isEmpty == false || dealerShipListArrya.count != 0{
                            self.dealerShipListArray += dealerShipListArrya
                            self.VC?.noofelements = self.dealerShipListArray.count
                            if self.dealerShipListArray.count != 0 {
                                self.VC!.dealershipLocationTV.isHidden = false
                                self.VC!.noDataFoundLbl.isHidden = true
                                self.VC!.dealershipLocationTV.reloadData()
                            }else{
                                self.VC!.dealershipLocationTV.isHidden = true
                                self.VC!.noDataFoundLbl.isHidden = false
                            }
                        }else{
                            if self.VC!.startindex > 1{
                                self.VC?.startindex = 1
                                self.VC?.noofelements = 9
                            }else{
                                self.VC?.dealershipLocationTV.isHidden = true
                                self.VC?.noDataFoundLbl.isHidden = false
                            }

                        }

                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    self.VC?.loaderView.isHidden = true
                }
            }
        }
    }
}
