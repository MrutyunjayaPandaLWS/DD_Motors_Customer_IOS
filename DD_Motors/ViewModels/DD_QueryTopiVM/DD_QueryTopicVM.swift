//
//  DD_QueryTopicVM.swift
//  DD_Motors
//
//  Created by ADMIN on 28/12/2022.
//

import UIKit
import Toast_Swift

class DD_QueryTopicVM {
    
    weak var VC: DD_QueryTopicVC?
    var pushID = UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
    var requestAPIs = RestAPI_Requests()
    var helpTopicListArray = [ObjHelpTopicList]()
    
    func helpTopiceListAPi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
         self.VC?.playAnimation2()
        self.requestAPIs.getHelpTopicList(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        self.helpTopicListArray = result?.objHelpTopicList ?? []
                        if self.helpTopicListArray.count != 0 {
                            self.VC?.queryTopicCollectionView.isHidden = false
                            self.VC?.queryTopicCollectionView.reloadData()
                        }else{
                            self.VC?.view.makeToast("No data found !!", duration: 3.0, position: .bottom)
                            self.VC?.queryTopicCollectionView.isHidden = true
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
