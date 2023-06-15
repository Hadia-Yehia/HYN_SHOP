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
  
             return "https://mad43-alex-ios2.myshopify.com/"
        }
    }
    
    public var accessToken : HTTPHeaders {
        get{
            return ["X-Shopify-Access-Token":"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"]
            
        }
    }
    public var contentType : HTTPHeaders {
        get{
            return ["Content-Type": "application/json"]
            
        }
    }
    public var productDetailsEndPoint : String{
        get{
            return "products/8348491710749.json"
        }
    }
    public var brandEndPoint : String{
        get{
            return "smart_collections.json"
        }
    }
    
    public var currencyUrl: String
    {
        get
        {
            return "https://open.er-api.com/v6/latest/USD"
        }
    }
    
    
   
    
 
}
