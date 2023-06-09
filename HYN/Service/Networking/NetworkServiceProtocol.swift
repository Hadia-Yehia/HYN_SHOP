//
//  NetworkServiceProtocol.swift
//  HYN
//
//  Created by Hadia Yehia on 08/06/2023.
//

import Foundation
protocol NetworkServiceProtocol{
    func fetchingProductDetails(product_id : Int,completionHandler : @escaping(_ result: Result<ProductResponse,NetworkError>)->Void)
}
