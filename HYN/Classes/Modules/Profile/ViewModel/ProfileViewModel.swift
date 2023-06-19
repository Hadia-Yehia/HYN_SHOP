//
//  ProfileViewModel.swift
//  HYN
//
//  Created by Nada youssef on 18/06/2023.
//

import Foundation
class ProfileViewModel{
  //  var observable: Observable<Bool> = Observable(false)
    var favItems:[Fav] = []
    
    func getCartItems()
    {
       // observable.value = true
        favItems =  FavCoreData.fetchProductsFromDataBase()
       // observable.value = false
    }
    func getCartItem(index:Int)->Fav
    {
        return favItems[index]
    }
    func getCartItemsCount()->Int
    {
        if favItems.count >= 2
        {
            return 2
        }
        else
        {
            return favItems.count
        }
    }
    func checkIfCartHasItems()->Bool
    {
        if favItems.count > 0
        {
            return true
        }
        else
        {
            return false
        }
      
    }
    
}
