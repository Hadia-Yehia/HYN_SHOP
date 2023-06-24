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
    var inventoryQuantity : Int
    init(name: String, price: String, description: String, rate: Float, imgs: [String], size: String, inventoryQuantity: Int) {
        self.name = name
        self.price = price
        self.description = description
        self.rate = rate
        self.imgs = imgs
        self.size = size
        self.inventoryQuantity = inventoryQuantity
    }
}
struct ReviewItem{
    var name : String
    var content  : String
    var rating : Float
    init(name: String, content: String, rating: Float) {
        self.name = name
        self.content = content
        self.rating = rating
    }
    
}
struct Fav{
    var title : String
    var price : String
    var img : String
    var id : Int
    var inventoryQuantity : Int
 
    init(title: String, price: String, img: String, id: Int, inventoryQuantity: Int) {
        self.title = title
        self.price = price
        self.img = img
        self.id = id
        self.inventoryQuantity = inventoryQuantity
    }
}
struct ProductsStruct{
    var id : Int
    var price : String
    var img : String
    var title : String
    var inventoryQuantity : Int

    init(id: Int, price: String, img: String, title: String, inventoryQuantity: Int) {
        self.id = id
        self.price = price
        self.img = img
        self.title = title
        self.inventoryQuantity = inventoryQuantity
    }
  
}
