//
//  Order.swift
//  HYN
//
//  Created by Nada youssef on 16/06/2023.
//

import Foundation

struct Order: Codable {
    var customer : CustomerResponse
    var lineItems : [LineItems]
    var address : Address
    var time : Int
    var totalCost : Double
    init(customer: CustomerResponse,lineItems:[LineItems],address : Address,time : Int,totalCost : Double) {
        self.customer = customer
        self.lineItems = lineItems
        self.address = address
        self.time = time
        self.totalCost = totalCost
    }

}
