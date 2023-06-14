//
//  Favourites.swift
//  HYN
//
//  Created by Hadia Yehia on 14/06/2023.
//

import Foundation
struct Fav{
    var title : String
    var price : String
    var img : String
    var id : Int
    init(title: String, price: String, img: String, id: Int) {
        self.title = title
        self.price = price
        self.img = img
        self.id = id
    }
}
