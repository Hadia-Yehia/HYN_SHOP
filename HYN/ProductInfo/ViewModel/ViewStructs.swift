//
//  ViewStructs.swift
//  HYN
//
//  Created by Hadia Yehia on 09/06/2023.
//

import Foundation
struct ProductInfo{
    var name : String
    var price : String
    var description : String
    var rate : Float
    var imgs : [String]
    var size : String
    init(name: String, price: String, description: String, rate: Float, imgs: [String], size: String) {
        self.name = name
        self.price = price
        self.description = description
        self.rate = rate
        self.imgs = imgs
        self.size = size
    }
}
