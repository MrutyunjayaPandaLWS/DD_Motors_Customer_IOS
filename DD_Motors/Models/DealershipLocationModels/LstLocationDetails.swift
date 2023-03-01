/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstLocationDetails : Codable {
	let rowNo : Int?
	let locationId : Int?
	let locationName : String?
	let locationCode : String?
	let cityName : String?
	let stateName : String?
	let countryId : Int?
	let stateId : Int?
	let cityId : Int?
	let isActive : Bool?
	let roleId : Int?
	let merchantId : Int?
	let mobile : String?
	let eMail : String?
	let totalCustomer : Int?
	let allCustomersCount : Int?
	let totalRows : Int?
	let monthName : String?
	let totalActiveMembers : Int?
	let totalInactiveMembers : Int?
	let totalVerifiedMembers : Int?
	let totalUnverifiedMembers : Int?
	let totActiveMembers : Int?
	let totInactiveMembers : Int?
	let totVerifiedMembers : Int?
	let totUnverifiedMembers : Int?
	let fromDate : String?
	let toDate : String?
	let actionType : Int?
	let membershipId : String?
	let membershipName : String?
	let enrolledDate : String?
	let executiveName : String?
	let pointsBalance : Int?
	let cC1 : String?
	let cC2 : String?
	let cC3 : String?
	let latitude : String?
	let longitude : String?
	let url : String?
	let locationImageName1 : String?
	let locationImageName2 : String?
	let objLocationAddressInfo : ObjLocationAddressInfo?
	let slNo : Int?
	let total : Int?
	let pageSize : Int?
	let staterIndex : Int?
	let programStartDate : String?
	let totalPurchase : Double?
	let totalAwarded : Int?
	let totalInvoices : Int?
	let userActionId : Int?
	let district : String?
	let searchText : String?
	let grandTotalCustomer : Int?
	let sumOfTotCust : String?
	let totMemMonth : Int?
	let asm : String?
	let se : String?
	let totalSellingPrice : Int?
	let totalRewardPointsCredited : Int?
	let grandTotalInvoices : Int?
	let locationUserID : Int?
	let billingTypeID : Int?
	let transactionDate : String?
	let area : Int?
	let locataionTypeId : Int?
	let parentLocationName : String?
	let parentLocationID : Int?
	let locationType : String?
	let productID : Int?
	let smsChildTemplate : String?
	let editLocationVisible : Bool?
	let uploadLocationImageVisible : Bool?
	let locationCityMappingVisible : Bool?
	let locationRegionMappingVisible : Bool?
	let locationBrandMappingVisible : Bool?
	let returnvalue : Int?
	let programBehaviourId : Int?
	let programBehaviourName : String?
	let districtId : Int?
	let talukId : Int?
	let customerType : String?
	let customerGrade : String?
	let subParentLocationID : Int?
	let brandId : Int?
	let locationQRCode : String?
	let locationQRImage : String?
	let crNumber : String?
	let domain : String?
	let loyaltyStatus : Int?
	let location_Name : String?
	let dashBoardRegionID : Int?
	let dashBoardDepotID : Int?
	let ccMobile1 : String?
	let ccMobile2 : String?
	let ccMobile3 : String?
	let ccName1 : String?
	let ccName2 : String?
	let ccName3 : String?
	let userName : String?
	let password : String?

	enum CodingKeys: String, CodingKey {

		case rowNo = "rowNo"
		case locationId = "locationId"
		case locationName = "locationName"
		case locationCode = "locationCode"
		case cityName = "cityName"
		case stateName = "stateName"
		case countryId = "countryId"
		case stateId = "stateId"
		case cityId = "cityId"
		case isActive = "isActive"
		case roleId = "roleId"
		case merchantId = "merchantId"
		case mobile = "mobile"
		case eMail = "eMail"
		case totalCustomer = "totalCustomer"
		case allCustomersCount = "allCustomersCount"
		case totalRows = "totalRows"
		case monthName = "monthName"
		case totalActiveMembers = "totalActiveMembers"
		case totalInactiveMembers = "totalInactiveMembers"
		case totalVerifiedMembers = "totalVerifiedMembers"
		case totalUnverifiedMembers = "totalUnverifiedMembers"
		case totActiveMembers = "totActiveMembers"
		case totInactiveMembers = "totInactiveMembers"
		case totVerifiedMembers = "totVerifiedMembers"
		case totUnverifiedMembers = "totUnverifiedMembers"
		case fromDate = "fromDate"
		case toDate = "toDate"
		case actionType = "actionType"
		case membershipId = "membershipId"
		case membershipName = "membershipName"
		case enrolledDate = "enrolledDate"
		case executiveName = "executiveName"
		case pointsBalance = "pointsBalance"
		case cC1 = "cC1"
		case cC2 = "cC2"
		case cC3 = "cC3"
		case latitude = "latitude"
		case longitude = "longitude"
		case url = "url"
		case locationImageName1 = "locationImageName1"
		case locationImageName2 = "locationImageName2"
		case objLocationAddressInfo = "objLocationAddressInfo"
		case slNo = "slNo"
		case total = "total"
		case pageSize = "pageSize"
		case staterIndex = "staterIndex"
		case programStartDate = "programStartDate"
		case totalPurchase = "totalPurchase"
		case totalAwarded = "totalAwarded"
		case totalInvoices = "totalInvoices"
		case userActionId = "userActionId"
		case district = "district"
		case searchText = "searchText"
		case grandTotalCustomer = "grandTotalCustomer"
		case sumOfTotCust = "sumOfTotCust"
		case totMemMonth = "totMemMonth"
		case asm = "asm"
		case se = "se"
		case totalSellingPrice = "totalSellingPrice"
		case totalRewardPointsCredited = "totalRewardPointsCredited"
		case grandTotalInvoices = "grandTotalInvoices"
		case locationUserID = "locationUserID"
		case billingTypeID = "billingTypeID"
		case transactionDate = "transactionDate"
		case area = "area"
		case locataionTypeId = "locataionTypeId"
		case parentLocationName = "parentLocationName"
		case parentLocationID = "parentLocationID"
		case locationType = "locationType"
		case productID = "productID"
		case smsChildTemplate = "smsChildTemplate"
		case editLocationVisible = "editLocationVisible"
		case uploadLocationImageVisible = "uploadLocationImageVisible"
		case locationCityMappingVisible = "locationCityMappingVisible"
		case locationRegionMappingVisible = "locationRegionMappingVisible"
		case locationBrandMappingVisible = "locationBrandMappingVisible"
		case returnvalue = "returnvalue"
		case programBehaviourId = "programBehaviourId"
		case programBehaviourName = "programBehaviourName"
		case districtId = "districtId"
		case talukId = "talukId"
		case customerType = "customerType"
		case customerGrade = "customerGrade"
		case subParentLocationID = "subParentLocationID"
		case brandId = "brandId"
		case locationQRCode = "locationQRCode"
		case locationQRImage = "locationQRImage"
		case crNumber = "crNumber"
		case domain = "domain"
		case loyaltyStatus = "loyaltyStatus"
		case location_Name = "location_Name"
		case dashBoardRegionID = "dashBoardRegionID"
		case dashBoardDepotID = "dashBoardDepotID"
		case ccMobile1 = "ccMobile1"
		case ccMobile2 = "ccMobile2"
		case ccMobile3 = "ccMobile3"
		case ccName1 = "ccName1"
		case ccName2 = "ccName2"
		case ccName3 = "ccName3"
		case userName = "userName"
		case password = "password"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rowNo = try values.decodeIfPresent(Int.self, forKey: .rowNo)
		locationId = try values.decodeIfPresent(Int.self, forKey: .locationId)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		locationCode = try values.decodeIfPresent(String.self, forKey: .locationCode)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
		countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
		stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
		merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		eMail = try values.decodeIfPresent(String.self, forKey: .eMail)
		totalCustomer = try values.decodeIfPresent(Int.self, forKey: .totalCustomer)
		allCustomersCount = try values.decodeIfPresent(Int.self, forKey: .allCustomersCount)
		totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
		monthName = try values.decodeIfPresent(String.self, forKey: .monthName)
		totalActiveMembers = try values.decodeIfPresent(Int.self, forKey: .totalActiveMembers)
		totalInactiveMembers = try values.decodeIfPresent(Int.self, forKey: .totalInactiveMembers)
		totalVerifiedMembers = try values.decodeIfPresent(Int.self, forKey: .totalVerifiedMembers)
		totalUnverifiedMembers = try values.decodeIfPresent(Int.self, forKey: .totalUnverifiedMembers)
		totActiveMembers = try values.decodeIfPresent(Int.self, forKey: .totActiveMembers)
		totInactiveMembers = try values.decodeIfPresent(Int.self, forKey: .totInactiveMembers)
		totVerifiedMembers = try values.decodeIfPresent(Int.self, forKey: .totVerifiedMembers)
		totUnverifiedMembers = try values.decodeIfPresent(Int.self, forKey: .totUnverifiedMembers)
		fromDate = try values.decodeIfPresent(String.self, forKey: .fromDate)
		toDate = try values.decodeIfPresent(String.self, forKey: .toDate)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		membershipId = try values.decodeIfPresent(String.self, forKey: .membershipId)
		membershipName = try values.decodeIfPresent(String.self, forKey: .membershipName)
		enrolledDate = try values.decodeIfPresent(String.self, forKey: .enrolledDate)
		executiveName = try values.decodeIfPresent(String.self, forKey: .executiveName)
		pointsBalance = try values.decodeIfPresent(Int.self, forKey: .pointsBalance)
		cC1 = try values.decodeIfPresent(String.self, forKey: .cC1)
		cC2 = try values.decodeIfPresent(String.self, forKey: .cC2)
		cC3 = try values.decodeIfPresent(String.self, forKey: .cC3)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		locationImageName1 = try values.decodeIfPresent(String.self, forKey: .locationImageName1)
		locationImageName2 = try values.decodeIfPresent(String.self, forKey: .locationImageName2)
		objLocationAddressInfo = try values.decodeIfPresent(ObjLocationAddressInfo.self, forKey: .objLocationAddressInfo)
		slNo = try values.decodeIfPresent(Int.self, forKey: .slNo)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
		pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
		staterIndex = try values.decodeIfPresent(Int.self, forKey: .staterIndex)
		programStartDate = try values.decodeIfPresent(String.self, forKey: .programStartDate)
		totalPurchase = try values.decodeIfPresent(Double.self, forKey: .totalPurchase)
		totalAwarded = try values.decodeIfPresent(Int.self, forKey: .totalAwarded)
		totalInvoices = try values.decodeIfPresent(Int.self, forKey: .totalInvoices)
		userActionId = try values.decodeIfPresent(Int.self, forKey: .userActionId)
		district = try values.decodeIfPresent(String.self, forKey: .district)
		searchText = try values.decodeIfPresent(String.self, forKey: .searchText)
		grandTotalCustomer = try values.decodeIfPresent(Int.self, forKey: .grandTotalCustomer)
		sumOfTotCust = try values.decodeIfPresent(String.self, forKey: .sumOfTotCust)
		totMemMonth = try values.decodeIfPresent(Int.self, forKey: .totMemMonth)
		asm = try values.decodeIfPresent(String.self, forKey: .asm)
		se = try values.decodeIfPresent(String.self, forKey: .se)
		totalSellingPrice = try values.decodeIfPresent(Int.self, forKey: .totalSellingPrice)
		totalRewardPointsCredited = try values.decodeIfPresent(Int.self, forKey: .totalRewardPointsCredited)
		grandTotalInvoices = try values.decodeIfPresent(Int.self, forKey: .grandTotalInvoices)
		locationUserID = try values.decodeIfPresent(Int.self, forKey: .locationUserID)
		billingTypeID = try values.decodeIfPresent(Int.self, forKey: .billingTypeID)
		transactionDate = try values.decodeIfPresent(String.self, forKey: .transactionDate)
		area = try values.decodeIfPresent(Int.self, forKey: .area)
		locataionTypeId = try values.decodeIfPresent(Int.self, forKey: .locataionTypeId)
		parentLocationName = try values.decodeIfPresent(String.self, forKey: .parentLocationName)
		parentLocationID = try values.decodeIfPresent(Int.self, forKey: .parentLocationID)
		locationType = try values.decodeIfPresent(String.self, forKey: .locationType)
		productID = try values.decodeIfPresent(Int.self, forKey: .productID)
		smsChildTemplate = try values.decodeIfPresent(String.self, forKey: .smsChildTemplate)
		editLocationVisible = try values.decodeIfPresent(Bool.self, forKey: .editLocationVisible)
		uploadLocationImageVisible = try values.decodeIfPresent(Bool.self, forKey: .uploadLocationImageVisible)
		locationCityMappingVisible = try values.decodeIfPresent(Bool.self, forKey: .locationCityMappingVisible)
		locationRegionMappingVisible = try values.decodeIfPresent(Bool.self, forKey: .locationRegionMappingVisible)
		locationBrandMappingVisible = try values.decodeIfPresent(Bool.self, forKey: .locationBrandMappingVisible)
		returnvalue = try values.decodeIfPresent(Int.self, forKey: .returnvalue)
		programBehaviourId = try values.decodeIfPresent(Int.self, forKey: .programBehaviourId)
		programBehaviourName = try values.decodeIfPresent(String.self, forKey: .programBehaviourName)
		districtId = try values.decodeIfPresent(Int.self, forKey: .districtId)
		talukId = try values.decodeIfPresent(Int.self, forKey: .talukId)
		customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
		customerGrade = try values.decodeIfPresent(String.self, forKey: .customerGrade)
		subParentLocationID = try values.decodeIfPresent(Int.self, forKey: .subParentLocationID)
		brandId = try values.decodeIfPresent(Int.self, forKey: .brandId)
		locationQRCode = try values.decodeIfPresent(String.self, forKey: .locationQRCode)
		locationQRImage = try values.decodeIfPresent(String.self, forKey: .locationQRImage)
		crNumber = try values.decodeIfPresent(String.self, forKey: .crNumber)
		domain = try values.decodeIfPresent(String.self, forKey: .domain)
		loyaltyStatus = try values.decodeIfPresent(Int.self, forKey: .loyaltyStatus)
		location_Name = try values.decodeIfPresent(String.self, forKey: .location_Name)
		dashBoardRegionID = try values.decodeIfPresent(Int.self, forKey: .dashBoardRegionID)
		dashBoardDepotID = try values.decodeIfPresent(Int.self, forKey: .dashBoardDepotID)
		ccMobile1 = try values.decodeIfPresent(String.self, forKey: .ccMobile1)
		ccMobile2 = try values.decodeIfPresent(String.self, forKey: .ccMobile2)
		ccMobile3 = try values.decodeIfPresent(String.self, forKey: .ccMobile3)
		ccName1 = try values.decodeIfPresent(String.self, forKey: .ccName1)
		ccName2 = try values.decodeIfPresent(String.self, forKey: .ccName2)
		ccName3 = try values.decodeIfPresent(String.self, forKey: .ccName3)
		userName = try values.decodeIfPresent(String.self, forKey: .userName)
		password = try values.decodeIfPresent(String.self, forKey: .password)
	}

}