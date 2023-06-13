//
//  Address.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 11/06/2023.
//

import Foundation
struct Address: Encodable,Decodable {

    var id:Int?
    var address1: String
    var address2: String?
    var first_name: String
    var last_name: String
    var name: String
    var city: String
    var country: String
    var company: String?
    var province: String?
    var phone: String
    var zip: String
    var province_code: String?
    var country_code: String?
    var country_name: String?
    var `default`: Bool?
    
    init(id:Int? = nil,address1: String, address2: String? = nil, first_name: String, last_name: String, name: String,
         city: String, country: String, company: String? = nil, province: String? = nil, phone: String,
         zip: String, province_code: String? = nil, country_code: String? = nil, country_name: String? = nil, default: Bool? = false) {
        self.address1 = address1
        self.address2 = address2
        self.first_name = first_name
        self.last_name = last_name
        self.name = name
        self.city = city
        self.country = country
        self.company = company
        self.province = province
        self.phone = phone
        self.zip = zip
        self.province_code = province_code
        self.country_code = country_code
        self.country_name = country_name
        self.`default` = `default`
    }
}
struct CustomerAddress:Encodable,Decodable{
    var customer_address:Address
    init (address:Address)
    {
        self.customer_address = address
    }
  
}
struct CustomerAddresses:Decodable{
    var addresses:[Address]
}

struct EmptyResponse: Decodable {}
