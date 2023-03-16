//
//  DD_PromotionsVM.swift
//  DD_Motors
//
//  Created by syed on 16/03/23.
//

import Foundation

class DD_PromotionsVM{

    weak var VC: DD_PromotionsVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var promotionArrayList = [LstPromotionJsonList]()
    func promotionListApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loadarView.isHidden = false
        self.VC?.emptyMessage.isHidden = true
//        self.VC?.playAnimation2()
//        self.promotionArrayList.removeAll()
        self.requestAPIs.promotionListAPi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.loadarView.isHidden = true
                        let promotionList = result?.lstPromotionJsonList ?? []
                        if promotionList.count != 0{
                            self.promotionArrayList += promotionList
                            self.VC?.noofelements = self.promotionArrayList.count
                            self.VC?.promotionListTV.reloadData()
                            self.VC?.stopLoading()
                        }else{
                            self.VC?.emptyMessage.isHidden = false
                            self.VC?.noofelements = 0
                            self.VC?.startindex = 1
                            self.VC?.stopLoading()
                            self.VC?.promotionListTV.reloadData()
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.emptyMessage.isHidden = false
                        self.VC?.loadarView.isHidden = true
                        self.VC?.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.VC?.emptyMessage.isHidden = false
                    self.VC?.loadarView.isHidden = true
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
}
