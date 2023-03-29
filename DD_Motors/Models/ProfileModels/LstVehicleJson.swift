/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstVehicleJson : Codable {
	let vehicleId : Int?
	let vehicleNo : String?
	let vinChasis : String?
	let modelNo : String?
	let jVehicleBrand : String?
	let vehicleType : String?
	let fuelType : String?
	let engineNumber : String?
	let vehicleModelNumber : String?
	let insuranceExpiryDate : String?
	let laborAmount : String?
	let policyNumber : String?
	let policyDate : String?
	let insuranceRenewalNumber : String?
	let payload : String?
	let presentKM : String?
	let drivenBy : String?
	let isDriverChanging : String?
	let averageRunningPerMonth : String?
	let insuranceCompany : String?
	let invoiceNumber : String?
	let invoiceDate : String?
	let serviceDueDate : String?
	let modelName : String?
	let isVinNumberActive : Bool?
	let isVehicleActive : Bool?
	let fuelTypeID : Int?

	enum CodingKeys: String, CodingKey {

		case vehicleId = "vehicleId"
		case vehicleNo = "vehicleNo"
		case vinChasis = "vinChasis"
		case modelNo = "modelNo"
		case jVehicleBrand = "jVehicleBrand"
		case vehicleType = "vehicleType"
		case fuelType = "fuelType"
		case engineNumber = "engineNumber"
		case vehicleModelNumber = "vehicleModelNumber"
		case insuranceExpiryDate = "insuranceExpiryDate"
		case laborAmount = "laborAmount"
		case policyNumber = "policyNumber"
		case policyDate = "policyDate"
		case insuranceRenewalNumber = "insuranceRenewalNumber"
		case payload = "payload"
		case presentKM = "presentKM"
		case drivenBy = "drivenBy"
		case isDriverChanging = "isDriverChanging"
		case averageRunningPerMonth = "averageRunningPerMonth"
		case insuranceCompany = "insuranceCompany"
		case invoiceNumber = "invoiceNumber"
		case invoiceDate = "invoiceDate"
		case serviceDueDate = "serviceDueDate"
		case modelName = "modelName"
		case isVinNumberActive = "isVinNumberActive"
		case isVehicleActive = "isVehicleActive"
		case fuelTypeID = "fuelTypeID"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		vehicleId = try values.decodeIfPresent(Int.self, forKey: .vehicleId)
		vehicleNo = try values.decodeIfPresent(String.self, forKey: .vehicleNo)
		vinChasis = try values.decodeIfPresent(String.self, forKey: .vinChasis)
		modelNo = try values.decodeIfPresent(String.self, forKey: .modelNo)
		jVehicleBrand = try values.decodeIfPresent(String.self, forKey: .jVehicleBrand)
		vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType)
		fuelType = try values.decodeIfPresent(String.self, forKey: .fuelType)
		engineNumber = try values.decodeIfPresent(String.self, forKey: .engineNumber)
		vehicleModelNumber = try values.decodeIfPresent(String.self, forKey: .vehicleModelNumber)
		insuranceExpiryDate = try values.decodeIfPresent(String.self, forKey: .insuranceExpiryDate)
		laborAmount = try values.decodeIfPresent(String.self, forKey: .laborAmount)
		policyNumber = try values.decodeIfPresent(String.self, forKey: .policyNumber)
		policyDate = try values.decodeIfPresent(String.self, forKey: .policyDate)
		insuranceRenewalNumber = try values.decodeIfPresent(String.self, forKey: .insuranceRenewalNumber)
		payload = try values.decodeIfPresent(String.self, forKey: .payload)
		presentKM = try values.decodeIfPresent(String.self, forKey: .presentKM)
		drivenBy = try values.decodeIfPresent(String.self, forKey: .drivenBy)
		isDriverChanging = try values.decodeIfPresent(String.self, forKey: .isDriverChanging)
		averageRunningPerMonth = try values.decodeIfPresent(String.self, forKey: .averageRunningPerMonth)
		insuranceCompany = try values.decodeIfPresent(String.self, forKey: .insuranceCompany)
		invoiceNumber = try values.decodeIfPresent(String.self, forKey: .invoiceNumber)
		invoiceDate = try values.decodeIfPresent(String.self, forKey: .invoiceDate)
		serviceDueDate = try values.decodeIfPresent(String.self, forKey: .serviceDueDate)
		modelName = try values.decodeIfPresent(String.self, forKey: .modelName)
		isVinNumberActive = try values.decodeIfPresent(Bool.self, forKey: .isVinNumberActive)
		isVehicleActive = try values.decodeIfPresent(Bool.self, forKey: .isVehicleActive)
		fuelTypeID = try values.decodeIfPresent(Int.self, forKey: .fuelTypeID)
	}

}