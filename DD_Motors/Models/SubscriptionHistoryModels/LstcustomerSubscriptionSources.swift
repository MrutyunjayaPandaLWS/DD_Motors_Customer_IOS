/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstcustomerSubscriptionSources : Codable {
    let subscription : String?
    let sourceType : String?
    let sourceValue : String?
    let amount : Int?
    let subscriptionDate : String?
    let pdf : String?
    let subscriptionid : Int?
    let dateOfPayment : String?
    let bidvinvrn : String?
    let amountPaid : String?
    let modeOfPayment : String?
    let totalPaid : String?
    let name : String?
    let mobileNo : String?
    let subscriptionStatus : Int?

    enum CodingKeys: String, CodingKey {

        case subscription = "subscription"
        case sourceType = "sourceType"
        case sourceValue = "sourceValue"
        case amount = "amount"
        case subscriptionDate = "subscriptionDate"
        case pdf = "pdf"
        case subscriptionid = "subscriptionid"
        case dateOfPayment = "dateOfPayment"
        case bidvinvrn = "bidvinvrn"
        case amountPaid = "amountPaid"
        case modeOfPayment = "modeOfPayment"
        case totalPaid = "totalPaid"
        case name = "name"
        case mobileNo = "mobileNo"
        case subscriptionStatus = "subscriptionStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subscription = try values.decodeIfPresent(String.self, forKey: .subscription)
        sourceType = try values.decodeIfPresent(String.self, forKey: .sourceType)
        sourceValue = try values.decodeIfPresent(String.self, forKey: .sourceValue)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        subscriptionDate = try values.decodeIfPresent(String.self, forKey: .subscriptionDate)
        pdf = try values.decodeIfPresent(String.self, forKey: .pdf)
        subscriptionid = try values.decodeIfPresent(Int.self, forKey: .subscriptionid)
        dateOfPayment = try values.decodeIfPresent(String.self, forKey: .dateOfPayment)
        bidvinvrn = try values.decodeIfPresent(String.self, forKey: .bidvinvrn)
        amountPaid = try values.decodeIfPresent(String.self, forKey: .amountPaid)
        modeOfPayment = try values.decodeIfPresent(String.self, forKey: .modeOfPayment)
        totalPaid = try values.decodeIfPresent(String.self, forKey: .totalPaid)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
        subscriptionStatus = try values.decodeIfPresent(Int.self, forKey: .subscriptionStatus)
    }

}
