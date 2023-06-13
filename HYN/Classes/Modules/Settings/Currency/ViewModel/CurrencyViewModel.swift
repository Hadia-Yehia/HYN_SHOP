//
//  CurrencyViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 10/06/2023.
//

import UIKit

class CurrencyViewModel {
    
    let currenciesArray = ["EGP","USD","EUR","AMD","AED"]
    let currentCurrency:String = "EGP"
    var observable: Observable <Bool> = Observable(false)
    
    func getCurrenciesArrayCount()->Int
    {
        currenciesArray.count
    }

    func getCurrency(index:Int)->String
    {
        currenciesArray[index]
    }
//    func getCurrencyExchange()
//    {
//        observable.value = false
//        NetworkService.sharedInstance.getCurrencyExchange()
//        {
//            result in
//            self.observable.value = true
//            switch result{
//            case .success(let data):
//                print("m3aya 3omla: \(data.rates.USD) ")
//
//                break
//            case .failure(let error):
//                print("error\(error.localizedDescription)")
//                break
//            }
//
//        }
//    }
    func selectInitialRow()->Int {
        if let index = currenciesArray.firstIndex(of:UserDefaults.standard.string(forKey: "currencyCode") ?? "EGP" ) {
            return index
              
           }
        return 0
       }
    
    func changeCurrencyInUserDefaults(newCurrencyCode:String)
    
    {
        UserDefaults.standard.set(newCurrencyCode, forKey: "currencyCode")
    }
}
