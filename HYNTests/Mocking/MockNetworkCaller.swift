//
//  MockAPICaller.swift
//  SportsHubTests
//
//  Created by Yousra Mamdouh Ali on 02/06/2023.
//

import UIKit
import Foundation
@testable import HYN
class MockNetworkCaller : Mockable {
    var shouldReturnError:Bool
   
    init(shouldReturnError:Bool)
    {
     
        self.shouldReturnError = shouldReturnError
    }
 
     enum ResponseWithError : Error
     {
         case responseError
     }


}
extension MockNetworkCaller
{
    
    // MARK: get currency exchange
    func getCurrencyExchange(url:String , complitionHandler: @escaping (Currency?,Error?)->Void)
    {
        if shouldReturnError
        {
            complitionHandler(nil,ResponseWithError.responseError)
        }else
        {
            do {
                let currency:Currency = try loadJSON(filename: "CurrencyResponse", type: Currency.self)
                complitionHandler(currency,nil)
            }catch
            {
                print("Error")
            }
    
        }
    }
    // MARK: get Brand Data

    func getBrandData(completionHandler: @escaping (Result<SmartCollectionsResult, NetworkError>) -> Void) {
        if shouldReturnError
        {
            completionHandler(.failure(.urlError))
        }else
        {
            do {
                let data:SmartCollectionsResult = try loadJSON(filename: "SmartCollections", type: SmartCollectionsResult.self)
                completionHandler(.success(data))
            }catch
            {
                print("Error")
            }
    
        }
    }
    
    // MARK: get product details
    func fetchingProductDetails(product_id: Int, completionHandler: @escaping (Result<ProductResponse, NetworkError>) -> Void)
    {
        if shouldReturnError
        {
            completionHandler(.failure(.urlError))
        }else
        {
            do {
                let data:ProductResponse = try loadJSON(filename: "ProductResponse", type: ProductResponse.self)
                completionHandler(.success(data))
            }catch
            {
                print("Error")
            }
    
        }
    }
    // MARK: Customer Request
    func requestNewCustomer(completionHandler : @escaping(Result<CustomerRequest, NetworkError>)->Void)
    {
        if shouldReturnError
        {
            completionHandler(.failure(.urlError))
        }else
        {
            do {
                let data:CustomerRequest = try loadJSON(filename: "CustomerRequest", type: CustomerRequest.self)
                completionHandler(.success(data))
            }catch
            {
                print("Error")
            }
    
        }
    }
    // MARK: Customer Response
    func postingNewCustomer(completionHandler : @escaping(Result<CustomerResponse, NetworkError>)->Void)
    {
        if shouldReturnError
        {
            completionHandler(.failure(.urlError))
        }else
        {
            do {
                let data:CustomerResponse = try loadJSON(filename: "CustomerResponse", type: CustomerResponse.self)
                completionHandler(.success(data))
            }catch
            {
                print("Error")
            }
    
        }
    }
    // MARK: DraftOrder Request
    func requestNewDraftOrder(completionHandler : @escaping(Result<DraftOrderRequest, NetworkError>)->Void)
    {
        if shouldReturnError
        {
            completionHandler(.failure(.urlError))
        }else
        {
            do {
                let data:DraftOrderRequest = try loadJSON(filename: "DraftOrderRequest", type: DraftOrderRequest.self)
                completionHandler(.success(data))
            }catch
            {
                print("Error")
            }
    
        }
    }
    // MARK: DraftOrder Response
    func postingNewDraftOrder(completionHandler : @escaping(Result<DraftOrderResponse, NetworkError>)->Void)
    {
        if shouldReturnError
        {
            completionHandler(.failure(.urlError))
        }else
        {
            do {
                let data:DraftOrderResponse = try loadJSON(filename: "DraftOrderResponse", type: DraftOrderResponse.self)
                completionHandler(.success(data))
            }catch
            {
                print("Error")
            }
    
        }
    }
    


}
