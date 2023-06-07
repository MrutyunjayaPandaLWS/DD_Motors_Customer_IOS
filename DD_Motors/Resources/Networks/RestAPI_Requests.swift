//
//  RestAPI_Requests.swift
//  Millers_Customer_App
//
//  Created by ArokiaIT on 10/30/20.
//

import UIKit

typealias JSON = [String: Any]

class RestAPI_Requests {
    private let client = WebClient(baseUrl: baseURl)
    
    //Get Login OTP
    func getloginOTP_API(parameters: JSON, completion: @escaping (OTPModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: saveOtp_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(OTPModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    //TermsAndCondion
    
    func termsAndCondion_API(parameters: JSON, completion: @escaping (TermsandConditionModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: termsAndCondition_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(TermsandConditionModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // Login Submission
    
    func loginApi(parameters: JSON, completion: @escaping (LoginModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: login_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(LoginModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Get State
    func getStateDetailsApi(parameters: JSON, completion: @escaping (StateModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: stateName_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(StateModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Get City
    func getCityDetailsApi(parameters: JSON, completion: @escaping (CityModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: cityName_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(CityModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Registration Submission
    
    func registrationSubmissionApi(parameters: JSON, completion: @escaping (RegistrationSubmissionModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: registration_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(RegistrationSubmissionModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Help Topic
    func getHelpTopicList(parameters: JSON, completion: @escaping (HelpTopicModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getHelpTopics_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(HelpTopicModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // DashBoard
    func dashBoardApi(parameters: JSON, completion: @escaping (DashBoardModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: dashboard_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(DashBoardModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    //Delete Account
    
    func deleteAccountApi(parameters: JSON, completion: @escaping (DeleteAccountModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: deleteAccountMethodName, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(DeleteAccountModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    func userStatusApi(parameters: JSON, completion: @escaping (DashBoardModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: dashboard_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(DashBoardModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Query Listing
    func queryListApi(parameters: JSON, completion: @escaping (QueryListingModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: queryList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(QueryListingModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }

    
    // Chat Details
    
    func chatDetailsApi(parameters: JSON, completion: @escaping (ChatDetailsModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: chatDetails_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ChatDetailsModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Chat Submission
    
    func chatDetailsSubmissionApi(parameters: JSON, completion: @escaping (ChatSubmissionModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: chatSubmission_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ChatSubmissionModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // Profile Details
    
    func myProfileApi(parameters: JSON, completion: @escaping (MyProfileModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: profile_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyProfileModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // Profile Image update
    
    func myProfileImageUpdate(parameters: JSON, completion: @escaping (ProfileImageUpdateModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: profileImageUpdate, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProfileImageUpdateModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Query Topic List
  
    func queryTopicListApi(parameters: JSON, completion: @escaping (QueryTopicListModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: queryTopicList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(QueryTopicListModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //New Query Submission
    
    func newQuerySubmission(parameters: JSON, completion: @escaping (SubmitNewQueryModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: chatSubmission_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(SubmitNewQueryModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // Profile Update
    
    func profileUpdateApi(parameters: JSON, completion: @escaping (ProfileUpdateModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: profieUpdate_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ProfileUpdateModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // Dealer ship Location
    
    func dealerShipLocationApi(parameters: JSON, completion: @escaping (DealershipLocationModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: dealerShipLocation_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(DealershipLocationModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // My CashPoints:
    
    func myCashPointListApi(parameters: JSON, completion: @escaping (MyCashPointsModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: myCashPoint_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyCashPointsModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //DashBoard Vehicel list
    
    func dashBoardVehicleListAPi(parameters: JSON, completion: @escaping (DashBoardVehicelModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getVehicleDetailsMobile_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(DashBoardVehicelModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // Subscription History
    
    func subscriptionHistoryListingApi(parameters: JSON, completion: @escaping (SubscriptionHistoryModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getGiftSubscriptionSave_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(SubscriptionHistoryModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //Subscription Submission
    
    func SubscriptionSubmission(parameters: JSON, completion: @escaping (SubscriptionSubmissionModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getGiftSubscriptionSave_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(SubscriptionSubmissionModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // My offers
    
    func myOffersListApi(parameters: JSON, completion: @escaping (MyOffersListModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getGiftCardIssueMobileApp_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyOffersListModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    func myOffersDetailsApi(parameters: JSON, completion: @escaping (MyOffersDetailsModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getGiftCardIssueMobileApp_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyOffersDetailsModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    // Service History Api
    func serviceHistoryApi(parameters: JSON, completion: @escaping (ServiceHistoryModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getVehicleDetailsMobile_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ServiceHistoryModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //bannerImage_URLMethod
    
    func dashboardBannerImageListApi(parameters: JSON, completion: @escaping (BannerImageListModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: bannerImage_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(BannerImageListModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // My Offers category Models
    
    func myOffersCategoryListApi(parameters: JSON, completion: @escaping (MyOffersCategoryModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: bannerCategory_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MyOffersCategoryModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //getGiftCardIssueMobileApp_URLMethod
    
    // Scratch Submission
    
    func scratchSubmissionApi(parameters: JSON, completion: @escaping (ScratchSubmissionModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: getGiftCardIssueMobileApp_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ScratchSubmissionModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // Validate Status
    
    func validateStatusApi(parameters: JSON, completion: @escaping (ValidateStatusModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: validateStatus_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ValidateStatusModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
//    MARK: - PROMOTION LIST API IMPLEMENTATION
    
    func promotionListAPi(parameters: JSON, completion: @escaping (PromotionModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: promotionList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(PromotionModels.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
//   MARK: - GENERATE RECEIPT
    
    func generateReceiptApi(parameters: JSON, completion: @escaping (GenerateReceiptModel?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: generateReceipt_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(GenerateReceiptModel.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    
    
    // NOTIFICATION LISTING
    
    func notificationList(parameters: JSON, completion: @escaping (NotificationModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: historyNotification, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(NotificationModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
}

