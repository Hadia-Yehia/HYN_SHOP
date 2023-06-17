//
//  OrderResponse.swift
//  HYN
//
//  Created by Nada youssef on 16/06/2023.
//

import Foundation


struct OrderResponse: Codable {

  var order : OrderResponsed? = OrderResponsed()

  enum CodingKeys: String, CodingKey {

    case order = "order"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    order = try values.decodeIfPresent(OrderResponsed.self , forKey: .order )
 
  }

  init() {

  }

}
