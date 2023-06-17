//
//  OrderRequest.swift
//  HYN
//
//  Created by Nada youssef on 16/06/2023.
//

import Foundation
struct OrderRequest: Codable {
    var order : Order
   
    init(order:Order) {
        self.order = order
    }

}


struct OrderRESPONSE: Codable {
    var orders : [Order]

}






