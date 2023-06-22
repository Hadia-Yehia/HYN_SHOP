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

}
