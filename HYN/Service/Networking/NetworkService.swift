//
//  NetworkService.swift
//  HYN
//
//  Created by Hadia Yehia on 08/06/2023.
//

import Foundation
import Alamofire
class NetworkService:NetworkServiceProtocol{
    static let sharedInstance = NetworkService()
    private init(){}
    static func getInstance() -> NetworkService{
        return sharedInstance
    }
    
    func fetchingProductDetails(product_id: Int, completionHandler: @escaping (Result<ProductResponse, NetworkError>) -> Void) {
        AF.request(NetworkConstants.shared.baseUrl+NetworkConstants.shared.productDetailsEndPoint)
        .response{response in
            switch response.result{
            case .success(let data): do {
                print("success")
                let jsonData = try JSONDecoder().decode(ProductResponse.self, from: data!)
                completionHandler(.success(jsonData))
            }
                catch{
                    print("fail parse")
                    print(error.localizedDescription)
                    completionHandler(.failure(.canNotParseData))
                }
            case .failure(let error):
                print("fail url")
                print(error.localizedDescription)
                completionHandler(.failure(.urlError))
            }
            
        }
    }
    
    func getCurrencyExchange( completionHandler: @escaping (Result<Currency, NetworkError>) -> Void)
    {
        AF.request(NetworkConstants.shared.currencyUrl)
        .response{response in
            switch response.result{
            case .success(let data): do {
                print("success")
                let jsonData = try JSONDecoder().decode(Currency.self, from: data!)
                completionHandler(.success(jsonData))
            }
                catch{
                    print("fail parse")
                    print(error.localizedDescription)
                    completionHandler(.failure(.canNotParseData))
                }
            case .failure(let error):
                print("fail url")
                print(error.localizedDescription)
                completionHandler(.failure(.urlError))
            }
            
        }
    }
}
enum NetworkError : Error{
    case urlError
    case canNotParseData
}

