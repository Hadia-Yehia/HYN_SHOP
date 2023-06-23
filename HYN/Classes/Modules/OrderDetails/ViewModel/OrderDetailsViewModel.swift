//
//  OrderDetailsViewModel.swift
//  HYN
//
//  Created by Nada youssef on 19/06/2023.
//

import Foundation
class OrderDetailsViewModel{
    
   var orderData : OrderData
    init(orderData:OrderData)
    {
       // self.brandIdFromHome = brandId
        self.orderData = orderData
    }
    
    func calculatePrice(price : String)->String{
        let exchangeRate = CurrencyManager.getRequiredCurrencyExchange()
       // let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        let floatValue: Float = (Float(price) ?? 0.0) * exchangeRate
        let formattedString = String(format: "%.2f", floatValue)
     //  self.productLabel.text = "\(currencyCode)\(formattedString)"
        return (formattedString + (UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"))
    }
}
