//
//  CurrencyManager.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 10/06/2023.
//

import Foundation
class CurrencyManager
{
    static var requiredCurrency:Double?
 
    
    static func exchangePrice(to currency:String)->Double
    {
                NetworkService.sharedInstance.getCurrencyExchange()
                {
                    result in
                    switch result{
                    case .success(let data):
                        switch currency
                         {
                          case "EGP":
                              requiredCurrency = data.rates.EGP
                          case "EUR":
                              requiredCurrency = data.rates.EUR
                          case "AMD":
                              requiredCurrency = data.rates.AMD
                          case "AED":
                              requiredCurrency = data.rates.AED
                          default:
                              requiredCurrency = 1
}
                        break
                    case .failure(let error):
                        print("error\(error.localizedDescription)")
                      print("cann't exchange price")
                        break
                    }
        
                }
        return requiredCurrency ?? 1
            
    }
   
}
