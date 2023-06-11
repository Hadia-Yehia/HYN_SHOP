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
    //MARK: Currency Exchange
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
    
    //MARK: Customer Addresses
    func createNewAddress(address:Address, completionHandler: @escaping (Result<CustomerAddress, NetworkError>) -> Void) {
        let customerId = 7123084443958
        let url = "https://mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/customers/\(customerId)/addresses.json"
        
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
  
        
        let customerAddress = CustomerAddress(address: address)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let jsonData = try? encoder.encode(customerAddress) else {
            print("Error encoding JSON")
            return
        }
        
        AF.upload(
            jsonData,
            to: url,
            method: .post,
            headers: headers
        )
        .validate()
        .responseDecodable(of: CustomerAddress.self) { response in
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
    }
    
    func getCustomerAddresses(completionHandler: @escaping (Result<CustomerAddresses, NetworkError>) -> Void)
    {
       // let customerId =
        let url = "https://mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/customers/7122889146678/addresses.json"
    
        
        AF.request(url,headers: NetworkConstants.shared.accessToken)
            .response{response in
                switch response.result{
                case .success(let data): do {
                    print("success")
                    let jsonData = try JSONDecoder().decode(CustomerAddresses.self, from: data!)
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
    

