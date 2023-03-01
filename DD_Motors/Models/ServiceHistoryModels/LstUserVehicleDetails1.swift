/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstUserVehicleDetails1 : Codable {
	let loyaltyId : String?
	let vehicleId : Int?
	let vehicleModelNo : String?
	let vehicleRegistartionNo : String?
	let viNnumber : String?
	let userId : Int?
	let brandId : Int?
	let productCode : String?
	let productName : String?
	let brand : String?
	let colorName : String?
	let colorCode : String?
	let categoryName : String?
	let name : String?
	let locationCode : String?
	let tnxDate : String?
	let model : String?

	enum CodingKeys: String, CodingKey {

		case loyaltyId = "loyaltyId"
		case vehicleId = "vehicleId"
		case vehicleModelNo = "vehicleModelNo"
		case vehicleRegistartionNo = "vehicleRegistartionNo"
		case viNnumber = "viNnumber"
		case userId = "userId"
		case brandId = "brandId"
		case productCode = "productCode"
		case productName = "productName"
		case brand = "brand"
		case colorName = "colorName"
		case colorCode = "colorCode"
		case categoryName = "categoryName"
		case name = "name"
		case locationCode = "locationCode"
		case tnxDate = "tnxDate"
		case model = "model"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		vehicleId = try values.decodeIfPresent(Int.self, forKey: .vehicleId)
		vehicleModelNo = try values.decodeIfPresent(String.self, forKey: .vehicleModelNo)
		vehicleRegistartionNo = try values.decodeIfPresent(String.self, forKey: .vehicleRegistartionNo)
		viNnumber = try values.decodeIfPresent(String.self, forKey: .viNnumber)
		userId = try values.decodeIfPresent(Int.self, forKey: .userId)
		brandId = try values.decodeIfPresent(Int.self, forKey: .brandId)
		productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		brand = try values.decodeIfPresent(String.self, forKey: .brand)
		colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
		colorCode = try values.decodeIfPresent(String.self, forKey: .colorCode)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		locationCode = try values.decodeIfPresent(String.self, forKey: .locationCode)
		tnxDate = try values.decodeIfPresent(String.self, forKey: .tnxDate)
		model = try values.decodeIfPresent(String.self, forKey: .model)
	}

}
