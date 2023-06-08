//
//  Address.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit
import CoreData

class Address  {
    var address:String
    var nationality:String
    var phone:String
    var fullName:String
    var floor:String
    init(address:String,nationality:String,fullName:String,phone:String,floor:String)
    {
        self.address = address
        self.phone = phone
        self.fullName = fullName
        self.nationality = nationality
        self.floor = floor
    }
}
