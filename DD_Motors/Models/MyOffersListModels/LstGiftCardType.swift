/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstGiftCardType : Codable {
    let cardCatId : Int?
    let currencyId : Int?
    let giftCardTypeId : Int?
    let giftCardTypeName : String?
    let minTopUpValue : Double?
    let maxTopUpValue : Double?
    let fixedValue : Double?
    let cardNoFrom : Int?
    let cardNoTo : Int?
    let lCardExpiry : String?
    let issuedCardCount : Int?
    let message : String?
    let cardImagePath : String?
    let behaviourId : Int?
    let cardNumber : String?
    let ltyProgramBehaviour : String?
    let subscriptionStatus : String?
    let offerRedeemedId : Int?
    let offerEarendId : Int?
    let cardCatName : String?
    let expiry : Int?
    let expiryDate : String?
    let pinType : String?
    let isRedemption : Bool?
    let isTransferable : Bool?
    let hasPin : Bool?
    let isEncashBalance : Bool?
    let expiryStatus : String?
    let l_CardExpiry : String?
    let createdDate : String?
    let createdLocation : String?
    let isActive : Bool?
    let row : Int?
    let totalRow : Int?
    let startIndex : Int?
    let pageSize : Int?
    let isLocationAll : Bool?
    let termsAndConditions : String?
    let instruction : String?
    let is_Gifited : Int?
    let offerReferenceID : String?

    enum CodingKeys: String, CodingKey {

        case cardCatId = "cardCatId"
        case currencyId = "currencyId"
        case giftCardTypeId = "giftCardTypeId"
        case giftCardTypeName = "giftCardTypeName"
        case minTopUpValue = "minTopUpValue"
        case maxTopUpValue = "maxTopUpValue"
        case fixedValue = "fixedValue"
        case cardNoFrom = "cardNoFrom"
        case cardNoTo = "cardNoTo"
        case lCardExpiry = "lCardExpiry"
        case issuedCardCount = "issuedCardCount"
        case message = "message"
        case cardImagePath = "cardImagePath"
        case behaviourId = "behaviourId"
        case cardNumber = "cardNumber"
        case ltyProgramBehaviour = "ltyProgramBehaviour"
        case subscriptionStatus = "subscriptionStatus"
        case offerRedeemedId = "offerRedeemedId"
        case offerEarendId = "offerEarendId"
        case cardCatName = "cardCatName"
        case expiry = "expiry"
        case expiryDate = "expiryDate"
        case pinType = "pinType"
        case isRedemption = "isRedemption"
        case isTransferable = "isTransferable"
        case hasPin = "hasPin"
        case isEncashBalance = "isEncashBalance"
        case expiryStatus = "expiryStatus"
        case l_CardExpiry = "l_CardExpiry"
        case createdDate = "createdDate"
        case createdLocation = "createdLocation"
        case isActive = "isActive"
        case row = "row"
        case totalRow = "totalRow"
        case startIndex = "startIndex"
        case pageSize = "pageSize"
        case isLocationAll = "isLocationAll"
        case termsAndConditions = "termsAndConditions"
        case instruction = "instruction"
        case is_Gifited = "is_Gifited"
        case offerReferenceID = "offerReferenceID"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cardCatId = try values.decodeIfPresent(Int.self, forKey: .cardCatId)
        currencyId = try values.decodeIfPresent(Int.self, forKey: .currencyId)
        giftCardTypeId = try values.decodeIfPresent(Int.self, forKey: .giftCardTypeId)
        giftCardTypeName = try values.decodeIfPresent(String.self, forKey: .giftCardTypeName)
        minTopUpValue = try values.decodeIfPresent(Double.self, forKey: .minTopUpValue)
        maxTopUpValue = try values.decodeIfPresent(Double.self, forKey: .maxTopUpValue)
        fixedValue = try values.decodeIfPresent(Double.self, forKey: .fixedValue)
        cardNoFrom = try values.decodeIfPresent(Int.self, forKey: .cardNoFrom)
        cardNoTo = try values.decodeIfPresent(Int.self, forKey: .cardNoTo)
        lCardExpiry = try values.decodeIfPresent(String.self, forKey: .lCardExpiry)
        issuedCardCount = try values.decodeIfPresent(Int.self, forKey: .issuedCardCount)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        cardImagePath = try values.decodeIfPresent(String.self, forKey: .cardImagePath)
        behaviourId = try values.decodeIfPresent(Int.self, forKey: .behaviourId)
        cardNumber = try values.decodeIfPresent(String.self, forKey: .cardNumber)
        ltyProgramBehaviour = try values.decodeIfPresent(String.self, forKey: .ltyProgramBehaviour)
        subscriptionStatus = try values.decodeIfPresent(String.self, forKey: .subscriptionStatus)
        offerRedeemedId = try values.decodeIfPresent(Int.self, forKey: .offerRedeemedId)
        offerEarendId = try values.decodeIfPresent(Int.self, forKey: .offerEarendId)
        cardCatName = try values.decodeIfPresent(String.self, forKey: .cardCatName)
        expiry = try values.decodeIfPresent(Int.self, forKey: .expiry)
        expiryDate = try values.decodeIfPresent(String.self, forKey: .expiryDate)
        pinType = try values.decodeIfPresent(String.self, forKey: .pinType)
        isRedemption = try values.decodeIfPresent(Bool.self, forKey: .isRedemption)
        isTransferable = try values.decodeIfPresent(Bool.self, forKey: .isTransferable)
        hasPin = try values.decodeIfPresent(Bool.self, forKey: .hasPin)
        isEncashBalance = try values.decodeIfPresent(Bool.self, forKey: .isEncashBalance)
        expiryStatus = try values.decodeIfPresent(String.self, forKey: .expiryStatus)
        l_CardExpiry = try values.decodeIfPresent(String.self, forKey: .l_CardExpiry)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        createdLocation = try values.decodeIfPresent(String.self, forKey: .createdLocation)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        row = try values.decodeIfPresent(Int.self, forKey: .row)
        totalRow = try values.decodeIfPresent(Int.self, forKey: .totalRow)
        startIndex = try values.decodeIfPresent(Int.self, forKey: .startIndex)
        pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
        isLocationAll = try values.decodeIfPresent(Bool.self, forKey: .isLocationAll)
        termsAndConditions = try values.decodeIfPresent(String.self, forKey: .termsAndConditions)
        instruction = try values.decodeIfPresent(String.self, forKey: .instruction)
        is_Gifited = try values.decodeIfPresent(Int.self, forKey: .is_Gifited)
        offerReferenceID = try values.decodeIfPresent(String.self, forKey: .offerReferenceID)
    }

}
