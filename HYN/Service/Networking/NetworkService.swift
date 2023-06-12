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
    func postingNewCustomer(customer : CustomerRequest, completionHandler : @escaping(Result<CustomerRequest, NetworkError>)->Void){
        let url = "https://mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/customers.json"
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let jsonData = try? encoder.encode(customer)else{
            return
        }
             AF.upload(jsonData, to: url,method: .post,headers: headers).validate()
            .responseDecodable(of: CustomerRequest.self) { response in
                // Handle the response
                switch response.result {
                case .success(let value):
                    print("New address created: \(value)")
                    completionHandler(.success(value))
                case .failure(let error):
                    print("Error creating new address: \(error)")
                    completionHandler(.failure(.urlError))
                }
            }

        //  }).response(completionHandler: {response in
        //            switch response.result{
        //            case .success(let data): do{
        //                print("test\(data?.count ?? 0)")
        //                let jsonData = try JSONDecoder().decode(CustomerRequest.self, from: data!)
        //                completionHandler(.success(jsonData))
        //            }catch{
        //                print("fail parse")
        //                print(error.localizedDescription)
        //                completionHandler(.failure(.canNotParseData))
        //            }
        //            case .failure(let error):
        //                print("fail url")
        //                print(error.localizedDescription)
        //                completionHandler(.failure(.urlError))
        //
        //            }
        //
        //        })
        //
        //
        //    }
    }
}
enum NetworkError : Error{
    case urlError
    case canNotParseData
}

