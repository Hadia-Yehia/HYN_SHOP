//
//  ProfileViewModel.swift
//  HYN
//
//  Created by Nada youssef on 18/06/2023.
//

import Foundation
class ProfileViewModel{
  //  var observable: Observable<Bool> = Observable(false)
    var cartItems:[CartItem] = []
    
    func getCartItems()
    {
       // observable.value = true
       cartItems =  CartCoreData.shared.getCartItems()
       // observable.value = false
    }
    func getCartItem(index:Int)->CartItem
    {
        return cartItems[index]
    }
    func getCartItemsCount()->Int
    {
        if cartItems.count >= 2
        {
            return 2
        }
        else
        {
            return cartItems.count
        }
    }
    func checkIfCartHasItems()->Bool
    {
        if cartItems.count > 0
        {
            return true
        }
        else
        {
            return false
        }
      
    }
    
}
