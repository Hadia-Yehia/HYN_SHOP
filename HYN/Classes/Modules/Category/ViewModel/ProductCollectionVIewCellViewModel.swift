//
//  ProductCollectionVIewCellViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 21/06/2023.
//

import Foundation
class ProductCollectionViewCellViewModel{
    var favDataSource : [Fav]?
    func checkValidity(id:Int)-> Bool{
        favDataSource = FavCoreData.fetchProductsFromDataBase()
        for i in 0..<(favDataSource?.count ?? 0){
            if favDataSource?[i].id == id{
                return false
            }
        }
        return true
        
    }
    func addToFav(name : String,price:String,img:String,id:Int){
        let item = Fav(title: name, price: price, img: img, id: id)
        FavCoreData.saveProductToDataBase(item: item)
    }
    
    func changeCurrency(completion: @escaping (Float)-> ())
    {
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        CurrencyManager.exchangePrice(to: currencyCode) {
        exchangeRate in
//        let floatValue: Float = (Float(price) ?? 0.0) * exchangeRate
//        let formattedString = String(format: "%.2f", floatValue)
//        self.productLabel.text = "\(currencyCode)\(formattedString)"
//        completionHandler()
            completion(exchangeRate)
    
    }
    }
}
