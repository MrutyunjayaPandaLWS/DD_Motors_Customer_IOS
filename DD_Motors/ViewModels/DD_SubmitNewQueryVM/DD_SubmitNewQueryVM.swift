//
//  DD_SubmitNewQueryVM.swift
//  DD_Motors
//
//  Created by ADMIN on 29/12/2022.
//

import UIKit
import Kingfisher
class DD_SubmitNewQueryVM{
    
    weak var VC: DD_SubmitQueryVC?
    var requestAPIs = RestAPI_Requests()
    
    func querySubmissionApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
         self.VC?.playAnimation2()
        self.requestAPIs.newQuerySubmission(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        print(result?.returnMessage ?? "")
                        if result?.returnMessage ?? "" != "" || result?.returnMessage ?? nil != nil{
                        self.VC!.view.makeToast("Query Submitted successfully!", duration: 3.0, position: .bottom)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                                self.VC?.navigationController?.popViewController(animated: true)
                            })
                            
                    }else{
                        self.VC!.view.makeToast("Something went wrong please try again later.", duration: 3.0, position: .bottom)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                            self.VC?.navigationController?.popViewController(animated: true)
                        })
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
                self.VC?.loaderView.isHidden = true
                self.VC?.stopLoading()
                }
            }
        }
    }
    
}
