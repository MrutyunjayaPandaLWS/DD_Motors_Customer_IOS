//
//  DD_MyProfileVM.swift
//  DD_Motors
//
//  Created by ADMIN on 28/12/2022.
//

import UIKit
import Kingfisher
class DD_MyProfileVM{
    
    weak var VC: DD_MyProfileVC?
    var requestAPIs = RestAPI_Requests()
    
    func myProfileApi(parameter: JSON){
        DispatchQueue.main.async {
            self.VC?.startLoading()
            self.VC?.loaderView.isHidden = false
            self.VC?.playAnimation2()
        }
        self.requestAPIs.myProfileApi(parameters: parameter) { (result, error) in
            print(error,"jhcxbcj")
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        let profileDetails = result?.lstCustomerJson ?? []
                        let customerImage = String(profileDetails[0].profilePicture ?? "").dropFirst()
//                        self.VC?.profileImage.kf.setImage(with: URL(string: PROMO_IMG + "\(customerImage)"), placeholder: UIImage(named: "ic_default_img"))
                        self.VC?.nameTF.text = profileDetails[0].firstName ?? ""
                        self.VC?.mobileNumberTF.text = profileDetails[0].mobile ?? ""
                        self.VC?.addressTF.text = profileDetails[0].address1 ?? ""
                        self.VC?.stateTF.text = profileDetails[0].stateName ?? "Select State"
                        self.VC?.cityTF.text = profileDetails[0].cityName ?? "Select City"
                        self.VC?.pinCodeTF.text = profileDetails[0].zip ?? ""
                        self.VC?.addressID = "\(profileDetails[0].addressId ?? 0)"
                        //print(String(profileDetails[0].jdob ?? ""))
                        let dob = String(profileDetails[0].jdob ?? "").split(separator: " ")
                        if dob.count != 0 {
                            self.VC?.dobTF.text = "\(dob[0])"
                        }else{
                            self.VC?.dobTF.text = "Select DOB"
                        }
                       
                        self.VC?.selectedStateId = profileDetails[0].stateId ?? -1
                        self.VC?.selectedCityId = profileDetails[0].cityId ?? -1
                       
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
    
    func myProfileImageUpdateApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.requestAPIs.myProfileImageUpdate(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        self.VC?.loaderView.isHidden = true
                        print(result?.returnMessage ?? "")
                        if result?.returnMessage ?? "" == "1"{
                            self.VC!.view.makeToast("Profile image updated successfully", duration: 3.0, position: .bottom)
                        }else{
                            self.VC!.view.makeToast("Profile image updated successfully", duration: 3.0, position: .bottom)
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
    
    func myProfileUpdateApi(parameter: JSON){
        self.VC?.startLoading()
        self.VC?.loaderView.isHidden = false
        self.VC?.playAnimation2()
        self.requestAPIs.profileUpdateApi(parameters: parameter) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.VC?.loaderView.isHidden = true
                        self.VC?.stopLoading()
                        print(result?.returnMessage ?? "")
                        if result?.returnMessage ?? "" == "1"{
                            self.VC!.view.makeToast("Profile updated successfully", duration: 3.0, position: .bottom)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                self.VC!.editOutBtn.setTitle("Edit Profile", for: .normal)
                                self.VC!.nameTF.isEnabled = false
                                self.VC!.mobileNumberTF.isEnabled = false
                                self.VC!.addressTF.isEnabled = false
                                self.VC!.stateTF.isEnabled = false
                                self.VC!.cityTF.isEnabled = true
                                self.VC!.pinCodeTF.isEnabled = false
                                self.VC!.dobTF.isEnabled = false
                                self.VC!.dobBtn.isEnabled = false
                                self.VC!.stateButton.isEnabled = false
                                self.VC!.cityBtn.isEnabled = false
                                self.VC?.myProfileDetails()
                            })
                            
                        }else{
                            self.VC!.view.makeToast("Profile updated Failed", duration: 3.0, position: .bottom)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                self.VC?.myProfileDetails()
                                self.VC!.editOutBtn.setTitle("Edit Profile", for: .normal)
                                self.VC!.nameTF.isEnabled = false
                                self.VC!.mobileNumberTF.isEnabled = false
                                self.VC!.addressTF.isEnabled = false
                                self.VC!.stateTF.isEnabled = false
                                self.VC!.cityTF.isEnabled = true
                                self.VC!.pinCodeTF.isEnabled = false
                                self.VC!.dobTF.isEnabled = false
                                self.VC!.dobBtn.isEnabled = false
                                self.VC!.stateButton.isEnabled = false
                                self.VC!.cityBtn.isEnabled = false
                            })
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
