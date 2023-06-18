//
//  PaymentViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 13/06/2023.
//

import Foundation
import PassKit
class PaymentViewModel
{

 
    var observable: Observable<Bool> = Observable(false)
    var coupon:String
    var subTotal:Float
    var address:Address?
    var isCashSelected:Bool?
    var subTotalString:String = ""
    var totalString:String = ""
    var disscountString:String = ""
    let defaults = UserDefaults.standard
    var linesArr = [LineItems]()

    init(coupon: String, subTotal:Float,address:Address,isCashSelected:Bool) {
        self.coupon = coupon
        self.subTotal = subTotal
        self.address = address
        self.isCashSelected = isCashSelected
    }
    init()
    {
        self.coupon = ""
        subTotal = 0.0
        address = nil
        isCashSelected = nil
    }
    
    
    //post order
    func saveOrder()
    {
       let productArr = CartCoreData.shared.getCartItems()
        /*for i in 0..<(productArr.count ?? 0){
            linesArr[i].title = productArr[i].title
            linesArr[i].price = String(productArr[i].price)
            linesArr[i].quantity = productArr[i].quantity
        }*/
        
        
        for item in productArr{
            var product = LineItems(title: "", price: "", quantity: 0)
            product.title = item.title
            product.price = String(item.price)
            product.quantity = item.quantity
            linesArr.append(product)
            
        }
       // var customer = CustomerResponse(customer: CustomerResponsed())
    
        let id = UserDefaults.standard.object(forKey: "userId") as? Int
       // let email  = "nada_youssef@gmail.com"
        print("sabah el kher",id)
        var customer = PostCustoer(id: id!)
     //   let id = self.defaults.object(forKey: "userId")
        print("orderssssss",linesArr)
        let order = Order(customer:customer, lineItems: linesArr)
       let myOrder  = OrderRequest(order: order)
        NetworkService.postingOrder(order: myOrder){ data, response, error in
            let response = String(data:data!,encoding: .utf8)
                            print(response!)
        }
           
        
    
    }
    
    
    func setDisscountCoupon()-> String
    {
        switch coupon
        {
        case Coupon.thirtyPercent.rawValue:
            return "30%"
        case Coupon.twentyPersent.rawValue:
            return "20%"
        case Coupon.fiftyPersent.rawValue:
            return "50%"
        case Coupon.fifteenPercent.rawValue:
            return "15%"
        default:
            return "0%"
        }
    }
    
    
    func calculateTotalPrice()->Float{
        switch coupon
        {
            
        case Coupon.thirtyPercent.rawValue:
            return subTotal-subTotal*0.3
        case Coupon.twentyPersent.rawValue:
            return subTotal-subTotal*0.2
        case Coupon.fiftyPersent.rawValue:
            return subTotal-subTotal*0.5
        case Coupon.fifteenPercent.rawValue:
            return subTotal-subTotal*0.15
        default:
            return subTotal*1
        }
    }
    
    func calculateDisscount()-> Float
    {
        switch coupon
        {
        case Coupon.thirtyPercent.rawValue:
            return -subTotal*0.3
        case Coupon.twentyPersent.rawValue:
            return -subTotal*0.2
        case Coupon.fiftyPersent.rawValue:
            return -subTotal*0.5
        case Coupon.fifteenPercent.rawValue:
            return -subTotal*0.15
        default:
            return -subTotal*0
        }

    }
    
    
    func checkCurrency()
    {
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        self.observable.value = true
        CurrencyManager.exchangePrice(to: currencyCode) {
            exchangeRate in
            self.formatePrices(exchangeRate: exchangeRate)
            self.observable.value = false
        }
    }
    
    func formatePrices(exchangeRate:Float)
    
    {
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        self.subTotalString = String(format: "%.2f", self.subTotal * exchangeRate) + "\(currencyCode)"
        self.totalString = String(format: "%.2f", self.calculateTotalPrice()*exchangeRate) + "\(currencyCode)"
        self.disscountString = String(format: "%.2f", self.calculateDisscount()*exchangeRate) + "\(currencyCode)"
    }
    
    func purchasesingApplePay(completionHandler: @escaping (PKPaymentRequest) -> Void)
    {   let paymentRequest = PKPaymentRequest()
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        paymentRequest.merchantIdentifier = "your_merchant_identifier"
        paymentRequest.supportedNetworks = [.visa, .masterCard, .amex]
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.supportedCountries = ["EG" , "US"]
        paymentRequest.countryCode =  "EG"
        paymentRequest.currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        CurrencyManager.exchangePrice(to:  UserDefaults.standard.string(forKey: "currencyCode") ?? "USD")
        {
            exchangeRate in
            let amount = NSDecimalNumber(value: self.calculateTotalPrice()*exchangeRate)
            let roundedAmount = amount.rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: true, raiseOnUnderflow: true, raiseOnDivideByZero: true))
            paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "HYN SHOP", amount: roundedAmount)]
            completionHandler(paymentRequest)
            
        }
      
       
   

    }
    

}
enum Coupon:String{
    case thirtyPercent = "7t65dehbj874"
    case twentyPersent = "rfrkj893nmn4"
    case fiftyPersent = "498ojf84jw3s"
    case fifteenPercent = "tj99484r87u1"
}
