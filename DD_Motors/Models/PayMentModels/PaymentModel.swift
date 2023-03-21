/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct PaymentModel : Codable {
	let cf_order_id : Int?
	let created_at : String?
	let customer_details : Customer_details?
	let entity : String?
	let order_amount : Double?
	let order_currency : String?
	let order_expiry_time : String?
	let order_id : String?
	let order_meta : Order_meta?
	let order_note : String?
	let order_splits : [String]?
	let order_status : String?
	let order_tags : String?
	let payment_session_id : String?
	let payments : Payments?
	let refunds : Refunds?
	let settlements : Settlements?
	let terminal_data : String?

	enum CodingKeys: String, CodingKey {

		case cf_order_id = "cf_order_id"
		case created_at = "created_at"
		case customer_details = "customer_details"
		case entity = "entity"
		case order_amount = "order_amount"
		case order_currency = "order_currency"
		case order_expiry_time = "order_expiry_time"
		case order_id = "order_id"
		case order_meta = "order_meta"
		case order_note = "order_note"
		case order_splits = "order_splits"
		case order_status = "order_status"
		case order_tags = "order_tags"
		case payment_session_id = "payment_session_id"
		case payments = "payments"
		case refunds = "refunds"
		case settlements = "settlements"
		case terminal_data = "terminal_data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cf_order_id = try values.decodeIfPresent(Int.self, forKey: .cf_order_id)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		customer_details = try values.decodeIfPresent(Customer_details.self, forKey: .customer_details)
		entity = try values.decodeIfPresent(String.self, forKey: .entity)
		order_amount = try values.decodeIfPresent(Double.self, forKey: .order_amount)
		order_currency = try values.decodeIfPresent(String.self, forKey: .order_currency)
		order_expiry_time = try values.decodeIfPresent(String.self, forKey: .order_expiry_time)
		order_id = try values.decodeIfPresent(String.self, forKey: .order_id)
		order_meta = try values.decodeIfPresent(Order_meta.self, forKey: .order_meta)
		order_note = try values.decodeIfPresent(String.self, forKey: .order_note)
		order_splits = try values.decodeIfPresent([String].self, forKey: .order_splits)
		order_status = try values.decodeIfPresent(String.self, forKey: .order_status)
		order_tags = try values.decodeIfPresent(String.self, forKey: .order_tags)
		payment_session_id = try values.decodeIfPresent(String.self, forKey: .payment_session_id)
		payments = try values.decodeIfPresent(Payments.self, forKey: .payments)
		refunds = try values.decodeIfPresent(Refunds.self, forKey: .refunds)
		settlements = try values.decodeIfPresent(Settlements.self, forKey: .settlements)
		terminal_data = try values.decodeIfPresent(String.self, forKey: .terminal_data)
	}

}
