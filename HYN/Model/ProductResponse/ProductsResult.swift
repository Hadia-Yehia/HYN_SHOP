//
//  ProductsResult.swift
//  HYN
//
//  Created by Nada youssef on 11/06/2023.
//

import Foundation
struct ProductsResult: Decodable {

    let products: [Product]?
    
    enum CodingKeys: String, CodingKey {
       
        case products
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
 
        products = try container.decodeIfPresent([Product].self, forKey: .products)
    }
}





