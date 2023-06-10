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
    
    var AED:Double
    var AMD:Double
    var EUR:Double
    var EGP:Double
}
