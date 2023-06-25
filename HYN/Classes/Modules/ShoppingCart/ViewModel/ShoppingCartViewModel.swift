//
//  ShoppingCartViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 14/06/2023.
//

import Foundation
class ShoppingCartViewModel{
    var observable: Observable<Bool> = Observable(false)

    
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
            print(item.id)
               }

        checkCurrency()
        self.observable.value = true
       
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
    
    

    func incrementCartItemQuantity(at index: Int)->Bool {
        if cartItemsArray[index].inventoryQuantity > cartItemsArray[index].quantity
        {
            print ("el motaaa7i: \(cartItemsArray[index].inventoryQuantity)")
            CartCoreData.shared.updateCartItem(cartItemsArray[index],operation: "inc")
            self.getCartItemsFromCoreData()
            return true
        }
        else
        {
       return false
        }
     
    }
    
    func decrementCartItemQuantity(at index: Int) {
        CartCoreData.shared.updateCartItem(cartItemsArray[index],operation: "dec")
        self.getCartItemsFromCoreData()

    }
        
//    func checkCurrency()
//    {
//        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
//        CurrencyManager.exchangePrice(to: currencyCode) {
//            exchangeRate in
//            let floatValue: Float = self.totalPrice * exchangeRate
//            let formattedString = String(format: "%.2f", floatValue)
//            self.newCurrency = "\(currencyCode)\(formattedString)"
//            self.observable.value = true
//
//        }
//
//    }
    func checkCurrency()
    {
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
       let exchangeRate =  CurrencyManager.getRequiredCurrencyExchange()
        let floatValue: Float = self.totalPrice * exchangeRate
        let formattedString = String(format: "%.2f", floatValue)
        self.newCurrency = "\(currencyCode)\(formattedString)"
        self.observable.value = true
        
    }
    
  
//func navigateToPaymentOptionsViewModel()->PaymentOptionsViewModel
//    {
//        return PaymentOptionsViewModel(subTotal: totalPrice)
//    }
    func navigateToAddresses()->AddressesViewModel
    {
        return AddressesViewModel(subTotal: totalPrice)
    }
    func navigateToDetails(index : Int) -> ProductInfoViewModel{
        return ProductInfoViewModel(productId: Int(cartItemsArray[index].id))
        }
    
    }
