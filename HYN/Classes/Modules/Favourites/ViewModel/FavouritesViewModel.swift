//
//  FavouritesViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import Foundation

class FavouritesViewModel{
        var dataSource : [Fav]?
        var isLoading : Observable<Bool> = Observable(false)
        var favCell = Fav(title: "no data", price: "no data", img: "placeholder", id: 0,inventoryQuantity: 0)
        func getFav(){
            dataSource = FavCoreData.fetchProductsFromDataBase()
        }
        
        func getTableCount()-> Int{
            return dataSource?.count ?? 0
        }
        func getObjectForCell(index:Int)->Fav{
            favCell.img = dataSource?[index].img ?? "placeholder"
            favCell.title = dataSource?[index].title ?? "no data"
            favCell.id = dataSource?[index].id ?? 0
            favCell.price = dataSource?[index].price ?? "no data"
            return favCell
        }
        func deleteItem(index : Int){
           FavCoreData.deleteProduct(id: dataSource?[index].id ?? 0)
            dataSource?.remove(at: index)
        }
    func deleteItemFromCell(id : Int){
       FavCoreData.deleteProduct(id: id)
        for i in 0..<(dataSource?.count ?? 0){
            if dataSource?[i].id == id{
                dataSource?.remove(at: i)
            }
        }
        
    }
        func navigateToDetailsScreen(index : Int) -> ProductInfoViewModel {
            let id = dataSource?[index].id
            return ProductInfoViewModel(productId:id ?? 0)
            
        }
    func insertProductInCoreData(at index:Int,completionHandler:@escaping (Bool)->Void)
    {
 
        let cartProdct = dataSource?[index]
        let productPrice = Float(cartProdct?.price ?? "0") ?? 0
        let productId = cartProdct?.id ?? 0
        let productTitle = cartProdct?.title ?? ""
        let productImage = cartProdct?.img ?? "placeholder"
        let inventoryQuantity = cartProdct?.inventoryQuantity ?? 0
            let cartItem = CartItem(id:Int64( productId),
                                    title: productTitle,
                                    quantity: 1,
                                    image: productImage ,
                                    price:productPrice,
                                    defaultPrice:productPrice,inventoryQuantity: inventoryQuantity)
            
            if   CartCoreData.shared.InsertCartItem(cartItem)
               {
                completionHandler(true)
            }
               else
               {
                   completionHandler(false)
               }
     
    }
    func getCurrencyExchange(price:String)-> String
    {
        let exchangeRate = CurrencyManager.getRequiredCurrencyExchange()
       // let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        let floatValue: Float = (Float(price) ?? 0.0) * exchangeRate
        let formattedString = String(format: "%.2f", floatValue)
        return formattedString
       // self.productLabel.text = "\(currencyCode)\(formattedString)"
    }
 

    
}
