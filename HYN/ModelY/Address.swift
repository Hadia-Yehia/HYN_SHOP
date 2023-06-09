//
//  Address.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit
import CoreData

class Address  {
    var name:String
    var surename:String
    var phone:String
    var country:String
    var city:String
    var area:String
    var street:String
    var apartment:String
    var floor:String
    init(name: String, surname: String, phone: String, country: String, city: String, area: String, street: String, apartment: String, floor: String) {
            self.name = name
            self.surename = surname
            self.phone = phone
            self.country = country
            self.city = city
            self.area = area
            self.street = street
            self.apartment = apartment
            self.floor = floor
        }
}
