/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ObjLocationAddressInfo : Codable {
    let addressId : Int?
    let address1 : String?
    let address2 : String?
    let landmark : String?
    let cityId : Int?
    let stateId : Int?
    let countryId : Int?
    let cityName : String?
    let stateName : String?
    let countryName : String?
    let zip : String?
    let token : String?
    let actorId : Int?
    let isActive : Bool?
    let actorRole : String?
    let actionType : Int?

    enum CodingKeys: String, CodingKey {

        case addressId = "addressId"
        case address1 = "address1"
        case address2 = "address2"
        case landmark = "landmark"
        case cityId = "cityId"
        case stateId = "stateId"
        case countryId = "countryId"
        case cityName = "cityName"
        case stateName = "stateName"
        case countryName = "countryName"
        case zip = "zip"
        case token = "token"
        case actorId = "actorId"
        case isActive = "isActive"
        case actorRole = "actorRole"
        case actionType = "actionType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addressId = try values.decodeIfPresent(Int.self, forKey: .addressId)
        address1 = try values.decodeIfPresent(String.self, forKey: .address1)
        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
        landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
        countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
        countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
        actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
    }

}
