//
//  Customer.swift
//  HYN
//
//  Created by Hadia Yehia on 11/06/2023.
//

import Foundation

struct CustomerRequest : Codable{
    var customer : Customer
    init(customer: Customer) {
        self.customer = customer
    }
//    var dictionary: [String: Any] {
//        return ["customer":customer.nsDictionary
//        ]
//    }
//    var nsDictionary: NSDictionary {
//        return dictionary as NSDictionary
//    }
}


struct Customer : Codable{
    var first_name : String
    var last_name : String
    var email : String
    var phone : String?
    var verified_email : Bool
    var password : String
    var password_confirmation : String
    var send_email_welcome : Bool

    init(first_name: String, last_name: String, email: String, phone: String? = nil, verified_email: Bool, password: String, password_confirmation: String, send_email_welcome: Bool) {
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.phone = phone
        self.verified_email = verified_email
        self.password = password
        self.password_confirmation = password_confirmation
        self.send_email_welcome = send_email_welcome
    }

//    var dictionary: [String: Any] {
//        return ["first_name": first_name,
//                "last_name": last_name,
//                "email": email,
//                "phone": phone,
//                "verified_email":verified_email,
//                "password":password,
//                "password_confirmation":password_confirmation,
//                "send_email_welcome":send_email_welcome
//        ]
//    }
//    var nsDictionary: NSDictionary {
//        return dictionary as NSDictionary
//    }
}
//struct CustomerAddress : Encodable{
//    var address1 : String
//    var city : String
//    var province : String
//    var phone : String
//    var zip : String
//    var first_name : String
//    var last_name : String
//    var country : String
//    init(address1: String, city: String, province: String, phone: String, zip: String, first_name: String, last_name: String, country: String) {
//        self.address1 = address1
//        self.city = city
//        self.province = province
//        self.phone = phone
//        self.zip = zip
//        self.first_name = first_name
//        self.last_name = last_name
//        self.country = country
//    }
//}

