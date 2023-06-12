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
    func getBrandData(completionHandler: @escaping (Result<SmartCollectionsResult, NetworkError>) -> Void) {
        AF.request("https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/smart_collections.json")
        .response{response in
            switch response.result{
            case .success(let data): do {
                print("success")
                let jsonData = try JSONDecoder().decode(SmartCollectionsResult.self, from: data!)
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
    
    func getProductsData(completionHandler: @escaping (Result<ProductsResult, NetworkError>) -> Void) {
        AF.request("https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/products.json")
        .response{response in
            switch response.result{
            case .success(let data): do {
                print("success")
                let jsonData = try JSONDecoder().decode(ProductsResult.self, from: data!)
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
    
    func getProductsType(completionHandler: @escaping (Result<CustomCollectionsResult, NetworkError>) -> Void) {
        AF.request("https://3ec4212c45d4957fa3a49ab23d83ff1b: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@mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/custom_collections.json")
        .response{response in
            switch response.result{
            case .success(let data): do {
                print("success")
                let jsonData = try JSONDecoder().decode(CustomCollectionsResult.self, from: data!)
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
    
    func getBrandProductsData(brand_id: Int,completionHandler: @escaping (Result<ProductsResult, NetworkError>) -> Void) {
        print("in items \(brand_id)")
        AF.request("https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/products.json?collection_id=\(brand_id)")
        .response{response in
            switch response.result{
            case .success(let data): do {
                print(data)
                print("success in brand product data method")
                let jsonData = try JSONDecoder().decode(ProductsResult.self, from: data!)
                print("data after hiting\(jsonData.products?.count)")
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
    
    
    
    
//    func getBrandData(){
//                var urlTeam =
//                    "https://3ec4212c45d4957fa3a49ab23d83ff1b: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@mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/smart_collections.json"
//                      var url = URL(string: urlTeam)
//                      let request = URLRequest(url: url!)
//                      let session = URLSession(configuration: .default)
//                let task = session.dataTask(with: request) { data, response, error in
//                    guard error == nil else {
//                        // handle error
//                        print("error")
//                        return
//                    }
//                    guard let data = data else {
//                        // handle empty response
//                        print("empty data")
//                        return
//                    }
//                    do {
//                       // decode the response data using your model
//                       let result = try JSONDecoder().decode(SmartCollectionsResult.self, from: data)
//                        print(data.count)
//                        var brandObj = String()
//                        if let collections = result.smart_collections {
//                            var i = 0
//                            for collection in collections {
//                                //print(collection.image?.src)
//                                brandObj = (collection.image?.src)!
//                                i = i+1
//                                self.brandArray.append(brandObj)
//                            }
//                             DispatchQueue.main.async {
//                                 self.mediaCollection.reloadData()
//                                 self.brandsCollection.reloadData()
//
//                             }
//                        }
//                      } catch {
//                          // handle decoding error
//                          print("no dataaaaa")
//                          print("Error decoding response data: \(error)")
//                      }
//
//                    // handle response data here
//                    // for example, you can decode the JSON data using Codable
//
//                }
//
//                task.resume()
//    }
}

enum NetworkError : Error{
    case urlError
    case canNotParseData
}

