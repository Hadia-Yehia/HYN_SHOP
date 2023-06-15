//
//  ShoppingCartViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 14/06/2023.
//

import Foundation
class ShoppingCartViewModel{
    var observable: Observable<Bool> = Observable(false)
    
    var cartItemsArray:[CartItem] = []
    
    func getCartItemArrayCount()->Int
    {
        cartItemsArray.count
    }

    func getCartItemsFromCoreData()
    {
    
        cartItemsArray = CartCoreData.shared.getCartItems()
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
//        cartItems[index].quantity += 1
        print("inc index: \(index)")
        // ... update the corresponding CartItem object in Core Data ...
    }
    
    func decrementCartItemQuantity(at index: Int) {
        CartCoreData.shared.updateCartItem(cartItemsArray[index],operation: "dec")
        self.getCartItemsFromCoreData()
//        cartItems[index].quantity += 1

        print("dec index: \(index)")
    }
        
        
    }
