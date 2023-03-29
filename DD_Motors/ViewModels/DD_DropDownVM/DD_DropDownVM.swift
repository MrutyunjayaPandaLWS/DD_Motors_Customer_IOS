//
//  DD_DropDownVM.swift
//  DD_Motors
//
//  Created by ADMIN on 27/12/2022.
//

import Foundation
import Toast_Swift

class DD_DropDownVM {
    
    weak var VC: DD_DropDownVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var stateListArray = [StateList]()
    var cityListArray = [CityList]()
    var helpTopicListArray = [ObjHelpTopicList]()
    var subscriptionHistoryListingArray = [LstcustomerSubscriptionSources]()
    
    func myCashPointListingApi(parameter: JSON){
        self.VC?.startLoading()
        self.subscriptionHistoryListingArray.removeAll()
        self.requestAPIs.subscriptionHistoryListingApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        self.subscriptionHistoryListingArray = result?.lstcustomerSubscriptionSources ?? []
                        print(self.subscriptionHistoryListingArray.count)
                        if self.subscriptionHistoryListingArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                          //  self.VC?.noDataFoundLbl.isHidden = true
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.view.makeToast("No data found !!", duration: 3.0, position: .center)
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.noDataFoundLbl.isHidden = false
                        }
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        self.VC?.view.makeToast("No data found !!", duration: 3.0, position: .center)
                        self.VC?.dropDownTableView.isHidden = true
                      //  self.VC?.noDataFoundLbl.isHidden = false
                    }
                }
            }else{
                DispatchQueue.main.async {
                    print(error)
                    self.VC?.stopLoading()
                    self.VC?.loaderView.isHidden = true
                 self.VC?.view.makeToast("No data found !!", duration: 3.0, position: .center)
                    self.VC?.dropDownTableView.isHidden = true
                 //   self.VC?.noDataFoundLbl.isHidden = false
                }
            }
        }
    }
    func stateListApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
         self.VC?.playAnimation2()
        self.requestAPIs.getStateDetailsApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        self.stateListArray = result?.stateList ?? []
                        if self.stateListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.view.makeToast("No data found !!", duration: 3.0, position: .center)
                            self.VC?.dropDownTableView.isHidden = true
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
    func cityListApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
         self.VC?.playAnimation2()
        self.requestAPIs.getCityDetailsApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        self.cityListArray = result?.cityList ?? []
                        if self.cityListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.view.makeToast("No data found !!", duration: 3.0, position: .center)
                            self.VC?.dropDownTableView.isHidden = true
                           
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
    func helpTopiceListAPi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
         self.VC?.playAnimation2()
        self.requestAPIs.getHelpTopicList(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.helpTopicListArray = result?.objHelpTopicList ?? []
                        if self.helpTopicListArray.count != 0 {
                            self.VC?.dropDownTableView.isHidden = false
                            self.VC?.loaderView.isHidden = true
                            self.VC?.dropDownTableView.reloadData()
                        }else{
                            self.VC?.view.makeToast("No data found !!", duration: 3.0, position: .center)
                            self.VC?.dropDownTableView.isHidden = true
                            self.VC?.loaderView.isHidden = true
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
