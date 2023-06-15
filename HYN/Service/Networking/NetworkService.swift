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
        AF.request(NetworkConstants.shared.baseUrl+"products/\(product_id).json")
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
    func postingNewCustomer(customer : CustomerRequest, completionHandler : @escaping(Result<CustomerResponse, NetworkError>)->Void){
            let endpoint = "https://mad43-alex-ios2.myshopify.com/admin/api/2023-04/customers.json"
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "X-Shopify-Access-Token": "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"
            ]
       
            AF.request(endpoint, method: .post, parameters: convertToParameters(customer: customer), encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value): do {
                        print("success")
                        let jsonData = try JSONDecoder().decode(CustomerResponse.self, from: JSONSerialization.data(withJSONObject: value,options: .prettyPrinted))
                       // print("ya 3zizy\(jsonData.customer.id)")
                        completionHandler(.success(jsonData))
                    }
                        catch{
                            print("fail parse")
                            print(error.localizedDescription)
                            completionHandler(.failure(.canNotParseData))
                        }
                        print(value)
                    case .failure(let error):
                        // Handle the error
                        print(error)
                    }
                }
    }

    func postingNewDraftOrder(draftOrder : DraftOrder, completionHandler : @escaping(Result<DraftOrderResponse, NetworkError>)->Void){
      
    
       // draftOrder.lineItems?.append(LineItems(title: "base2", price: "0", quantity: 0))
        let draftOrderRequest = DraftOrderRequest(draft_order: draftOrder)
 
            let endpoint = "https://mad43-alex-ios2.myshopify.com/admin/api/2023-04/draft_orders.json"
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "X-Shopify-Access-Token": "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"
            ]
        print ("aywaaa\(convertDraftOrderRequestToParameter(draftOrderRequest: draftOrderRequest))")
            AF.request(endpoint, method: .post, parameters: convertDraftOrderRequestToParameter(draftOrderRequest: draftOrderRequest), encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value): do {
                        print("success")
                        let jsonData = try JSONDecoder().decode(DraftOrderResponse.self, from: JSONSerialization.data(withJSONObject: value,options: .prettyPrinted))
                        print("ya 3zizy\(jsonData.draftOrder?.id)")
                        completionHandler(.success(jsonData))
                    }
                        catch{
                            print("fail parse")
                            print(error.localizedDescription)
                            completionHandler(.failure(.canNotParseData))
                        }
                        print(value)
                    case .failure(let error):
                        // Handle the error
                        print("aywa shkk fe m7lo\(error)")
                    }
                }
    }
    func convertDraftOrderRequestToParameter(draftOrderRequest : DraftOrderRequest) -> [String : Any]{
        var parameters : [String : Any] = [:]
        parameters["draft_order"] = convertDraftOrderToParameters(draftOrder: draftOrderRequest.draft_order)
        return parameters
    }
    func convertDraftOrderToParameters(draftOrder : DraftOrder)->[String:Any]{
        var parameters : [String:Any] = [:]
        var arr = Array<[String:Any]>()
        for i in 0..<(draftOrder.lineItems?.count ?? 0){
            arr.append(convertLineItemsToParameters(lineItems: draftOrder.lineItems?[i] ?? LineItems(title: "base", price: "0", quantity: 0)))
        }
        parameters["line_items"] = arr
        return parameters
    
    }
    func convertLineItemsToParameters(lineItems:LineItems)->[String:Any]{
        var parameters : [String:Any] = [:]
    
        parameters["title"] = lineItems.title
        parameters["price"] = lineItems.price
        parameters["quantity"] = lineItems.quantity
        return parameters
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
            let customerId = 7125716238646
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
           let url = "https://mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/customers/7125716238646/addresses.json"
           
           
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
    

    

    
    
    
    
    
    func deleteAddressFromServer(addressId:Int,completionHandler: @escaping (Result<EmptyResponse, NetworkError>) -> Void) {
        let url = "https://mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/customers/7125716238646/addresses/\(addressId).json"
        let headers: HTTPHeaders = NetworkConstants.shared.accessToken
        
        AF.request(url,
                   method: .delete,
                   headers: headers)
        .validate()
        .responseDecodable(of: EmptyResponse.self) { response in
            switch response.result {
            case .success:
                print("Data deleted successfully")
                completionHandler(.success(EmptyResponse()))
            case .failure(let error):
                print("Error deleting data: \(error)")
                completionHandler(.failure(.urlError))
            }
        }
    }
    
    
    
    //MARK: Customer Addresses
    
    func updateCustomerAddress(addressId: Int, address: Address, completionHandler: @escaping (Result<CustomerAddress, NetworkError>) -> Void) {
           let url = "https://mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/customers/7125716238646/addresses/\(addressId).json"
           //  let customerId = 7123084443958
           
           
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
               method: .put,
               headers: headers
           )
           .validate()
           .responseDecodable(of: CustomerAddress.self) { response in
               // Handle the response
               switch response.result {
               case .success(let value):
                   print("Address updated: \(value)")
                   completionHandler(.success(value))
               case .failure(let error):
                   print("Error updating address: \(error)")
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
    //MARK: draft orders
    func getCustomerDraftOrder(draftOrderId:Int64,completionHandler: @escaping (Result<DraftOrderResponse, NetworkError>) -> Void)
       {
           // let customerId =
           let url = "https://mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/draft_orders/\(draftOrderId).json"
           
           
           AF.request(url,headers: NetworkConstants.shared.accessToken)
               .response{response in
                   switch response.result{
                   case .success(let data): do {
                       print("success")
                       let jsonData = try JSONDecoder().decode(DraftOrderResponse.self, from: data!)
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




