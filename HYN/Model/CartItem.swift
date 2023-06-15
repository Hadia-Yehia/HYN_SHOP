//
//  CartItem.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 14/06/2023.
//

import Foundation
struct CartItem
{
    var id : Int64
    var title: String
    var quantity:Int
    var image:String
    var price:Float
    var defaultPrice:Float
    init(id: Int64, title: String, quantity: Int, image: String, price: Float,defaultPrice:Float) {
            self.id = id
            self.title = title
            self.quantity = quantity
            self.image = image
            self.price = price
        self.defaultPrice = defaultPrice
        }
   
}
