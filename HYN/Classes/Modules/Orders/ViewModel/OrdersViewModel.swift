//
//  OrdersViewModel.swift
//  HYN
//
//  Created by Nada youssef on 18/06/2023.
//

import Foundation

class OrdersViewModel{
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
              //  print("title of order",data.orders[0].created_at)
                self.getData(data: data.orders)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func getData(data : [OrderData]){
        orderArr = [OrderData]()
        for i in 0..<data.count{
            let order = OrderData(customer: data[i].customer, lineItems: data[i].line_items, created_at: data[i].created_at, id: data[i].id, current_subtotal_price: data[i].current_subtotal_price, contact_email: data[i].contact_email)
            orderArr.append(order)
        }
         
    }
    func getCellPrice(index : Int)->String{
        let exchangeRate = CurrencyManager.getRequiredCurrencyExchange()
       // let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        let floatValue: Float = (Float(orderArr[index].current_subtotal_price) ?? 0.0) * exchangeRate
        let formattedString = String(format: "%.2f", floatValue)
     //  self.productLabel.text = "\(currencyCode)\(formattedString)"
        return (formattedString + (UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"))
    }
    func calculatePrice(price : String)->String{
        let exchangeRate = CurrencyManager.getRequiredCurrencyExchange()
       // let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        let floatValue: Float = (Float(price) ?? 0.0) * exchangeRate
        let formattedString = String(format: "%.2f", floatValue)
     //  self.productLabel.text = "\(currencyCode)\(formattedString)"
        return (formattedString + (UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"))
    }
    
    func getCellId(index : Int)->Int{
        return (orderArr[index].id)
    }
    
    func getCellDate(index : Int)->String{
        return (orderArr[index].created_at)
    }
    
    func getCellCount()->Int{
        return (orderArr.count)
    }
    
    func navigateToOrderDetailsView(index :Int) ->OrderDetailsViewModel
    {
      
        return OrderDetailsViewModel(orderData: orderArr[index])
    }
}
