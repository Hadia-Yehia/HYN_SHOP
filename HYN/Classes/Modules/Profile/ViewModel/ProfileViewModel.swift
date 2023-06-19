//
//  ProfileViewModel.swift
//  HYN
//
//  Created by Nada youssef on 18/06/2023.
//

import Foundation
class ProfileViewModel{
    var orderArr : [OrderData] = Array()
    let defaults = UserDefaults.standard
    var isLoading : Observable<Bool> = Observable(false)

    func getOrderData(){
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        let id = UserDefaults.standard.object(forKey: "userId") as? Int
        NetworkService.gettingOrder(customerID: id!) { (result : Result<OrderRESPONSE,Error>) in
            self.isLoading.value = false
            switch(result){
            case .success(let data):
                print(data.orders)
                print("title of order",data.orders[0].created_at)
                self.getData(data: data.orders)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func getData(data : [OrderData]){
        orderArr = [OrderData]()
        for i in 0..<data.count{
            let order = OrderData(customer: data[i].customer, lineItems: data[i].line_items, created_at: data[i].created_at, id: data[i].id, current_subtotal_price: data[i].current_subtotal_price)
            orderArr.append(order)
        }
         
    }
    func getCellPrice(index : Int)->String{
        return (orderArr[index].current_subtotal_price)
    }
    
    func getCellId(index : Int)->Int{
        return (orderArr[index].id)
    }
    
    func getCellDate(index : Int)->String{
        return (orderArr[index].created_at)
    }
    
    func getCellCount()->Int{
        if (orderArr.count > 1) {
return 2 
}
else
{
return (orderArr.count)
}
}


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
        print("")
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
