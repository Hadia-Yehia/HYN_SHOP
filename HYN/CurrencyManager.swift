//
//  CurrencyManager.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 10/06/2023.
//

import Foundation
class CurrencyManager
{
    static var requiredCurrency:Float?
    
    
    static func exchangePrice(to currency:String, completionHandler: @escaping (Float) -> Void)
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
                    completionHandler(requiredCurrency ?? 1.0)
                    
                case "EUR":
                    requiredCurrency = data.rates.EUR
                    completionHandler(requiredCurrency ?? 1.0)
                    
                case "AMD":
                    requiredCurrency = data.rates.AMD
                    completionHandler(requiredCurrency ?? 1.0)
                    
                case "AED":
                    requiredCurrency = data.rates.AED
                    completionHandler(requiredCurrency ?? 1.0)
                    
                default:
                    requiredCurrency = 1
                    completionHandler(requiredCurrency ?? 1.0)
                    break
                }
                case .failure(let error):
                    print("error\(error.localizedDescription)")
                    print("cann't exchange price")
                    break
                }
                
            }
            
        }
        static func getRequiredCurrencyExchange()->Float
    
    {
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        
        switch currencyCode
        {
        case "AED":
            return UserDefaults.standard.float(forKey: "AED")
        case "EGP":
            return UserDefaults.standard.float(forKey: "EGP")
        case "EUR":
            return UserDefaults.standard.float(forKey: "EUR")
        case "AMD":
           return   UserDefaults.standard.float(forKey: "AMD")
        default:
            return 1.0
            
        }
       
    }
    
}
