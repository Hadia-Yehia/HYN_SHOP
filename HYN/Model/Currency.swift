//
//  Currency.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 10/06/2023.
//

import UIKit

struct Currency:Decodable {
    
var result:String
    var rates:Rates

}
struct Rates:Decodable{
    var USD:Float
    var AED:Float
    var AMD:Float
    var EUR:Float
    var EGP:Float
}
