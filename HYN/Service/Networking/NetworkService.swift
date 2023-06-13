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
//    func postingNewCustomer(customer : CustomerRequest, completionHandler : @escaping(Result<CustomerResponse, NetworkError>)->Void){
//        let endpoint = "https://mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/customers.json"
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "X-Shopify-Access-Token": "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"
//        ]
//
//
//
//        AF.request(endpoint, method: .post, parameters: convertToParameters(customer: customer), encoding: JSONEncoding.default, headers: headers)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value): do {
//                    print("success")
//                    let jsonData = try JSONDecoder().decode(CustomerResponse.self, from: JSONSerialization.data(withJSONObject: value,options: .prettyPrinted))
//                   // print("ya 3zizy\(jsonData.customer.id)")
//                    completionHandler(.success(jsonData))
//                }
//                    catch{
//                        print("fail parse")
//                        print(error.localizedDescription)
//                        completionHandler(.failure(.canNotParseData))
//                    }
//                    print(value)
//                case .failure(let error):
//                    // Handle the error
//                    print(error)
//                }
//            }
        
        

            }
            func convertToParameters(customer : CustomerRequest) -> [String: Any] {
                var parameters: [String: Any] = [:]
                parameters["customer"] = convertCustomerTOParameters(customer: customer.customer)
                return parameters
            }
            func convertCustomerTOParameters(customer:Customer)->[String:Any]{
                var parameters : [String:Any] = [:]
                parameters["first_name"] = customer.first_name
                parameters["last_name"] = customer.last_name
                parameters["email"] = customer.email
                parameters["phone"] = customer.phone
                parameters["verified_email"] = customer.verified_email
                parameters["password"] = customer.password
                parameters["password_confirmation"] = customer.password_confirmation
                parameters["send_email_welcome"] = customer.send_email_welcome
                return parameters
            }
    
//}
enum NetworkError : Error{
    case urlError
    case canNotParseData
}

