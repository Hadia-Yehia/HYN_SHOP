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


struct OrderData: Codable {
    var customer : PostCustoer
    var line_items : [LineItems]
    var created_at : String
    var id : Int
    var current_subtotal_price :String
    var contact_email : String
  //  var address : Address
    //var time : Int
   // var totalCost : Double
    init(customer: PostCustoer,lineItems:[LineItems],created_at : String,id : Int,current_subtotal_price :String,contact_email : String) {
        self.customer = customer
        self.line_items = lineItems
        self.id = id
        self.current_subtotal_price = current_subtotal_price
        self.created_at = created_at
        self.contact_email = contact_email
      //  self.address = address
    }

}

struct PostCustoer:Codable{
    var id:Int?
   // var email:String?
}
