//
//  TestModel.swift
//  HYN
//
//  Created by Nada youssef on 12/06/2023.
//

import Foundation

struct TestNada:Decodable{
    var brandProducts:[ProductNada]?
}

struct ProductNada:Decodable{
    var title:String?
    var id:Int?
}
