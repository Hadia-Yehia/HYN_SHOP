//
//  NetworkConstants.swift
//  HYN
//
//  Created by Hadia Yehia on 09/06/2023.
//

import Alamofire
import Foundation
class NetworkConstants{
    public static var shared: NetworkConstants = NetworkConstants()
    private init() {}
    public var baseUrl : String{
        get{
            //return"https://3ec4212c45d4957fa3a49ab23d83ff1b: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@mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/"
             return "https://d097bbce1fd2720f1d64ced55f0e485b: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@mad43-alex-ios-team4.myshopify.com/admin/api/2023-04/"
        }
    }
    
    public var accessToken : HTTPHeaders {
        get{
            return["X-Shopify-Access-Token":"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"]
            
        }
    }
    public var productDetailsEndPoint : String{
        get{
            return "products/8348491710749.json"
        }
    }
    
    public var currencyUrl: String
    {
        get
        {
            return "https://open.er-api.com/v6/latest/USD"
        }
    }
    public var contentType : HTTPHeaders {
        get{
            return["Content-Type": "application/json"]
            
        }
    }
    
 
}
