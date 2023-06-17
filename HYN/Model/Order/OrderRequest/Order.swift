//
//  Order.swift
//  HYN
//
//  Created by Nada youssef on 16/06/2023.
//

import Foundation

struct Order: Codable {
    var customer : PostCustoer
    var line_items : [LineItems]
  //  var address : Address
    //var time : Int
   // var totalCost : Double
    init(customer: PostCustoer,lineItems:[LineItems]) {
        self.customer = customer
        self.line_items = lineItems
      //  self.address = address
    }

}


struct PostCustoer:Codable{
    var id:Int?
   // var email:String?
}
