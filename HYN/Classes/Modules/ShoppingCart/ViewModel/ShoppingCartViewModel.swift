//
//  ShoppingCartViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 14/06/2023.
//

import Foundation
class ShoppingCartViewModel{
    var observable: Observable<Bool> = Observable(false)
    var observable2: Observable<Bool> = Observable(false)
    
    var totalPrice:Float = 0.0
    var newCurrency:String = ""
    var cartItemsArray:[CartItem] = []
    
    func getCartItemArrayCount()->Int
    {
        cartItemsArray.count
    }

    func getCartItemsFromCoreData()
    {
        totalPrice = 0.0
        cartItemsArray = CartCoreData.shared.getCartItems()
        for item in cartItemsArray
                {
                    totalPrice = (totalPrice ) + item.price
               }
        checkCurrency()
        observable.value = true
    }
    

    func getCartItem(index:Int)->CartItem
    {
        cartItemsArray[index]
    }
    func deleteCartItem(index:Int)
    {
        CartCoreData.shared.deleteCartItem(cartItemsArray[index])
        cartItemsArray.remove(at: index)
        
    }
    func isCartItemArrayEmpty()-> Bool
    {
        if cartItemsArray.isEmpty
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    

    func incrementCartItemQuantity(at index: Int) {
        CartCoreData.shared.updateCartItem(cartItemsArray[index],operation: "inc")
        self.getCartItemsFromCoreData()
    }
    
    func decrementCartItemQuantity(at index: Int) {
        CartCoreData.shared.updateCartItem(cartItemsArray[index],operation: "dec")
        self.getCartItemsFromCoreData()

    }
        
    func checkCurrency()
    {  
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        CurrencyManager.exchangePrice(to: currencyCode) {
            exchangeRate in
            let floatValue: Float = self.totalPrice * exchangeRate
            let formattedString = String(format: "%.2f", floatValue)
            self.newCurrency = "\(currencyCode)\(formattedString)"
            
        }

    }

    
    }
