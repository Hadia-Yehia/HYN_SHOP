//
//  PaymentViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 13/06/2023.
//

import Foundation
class PaymentViewModel
{
    var observable: Observable<Bool> = Observable(false)
    var coupon:String?
    var subTotal:Float
    var subTotalString:String = "USD"
    var totalString:String = ""
    var disscountString:String = ""
    
    init(coupon: String? = "1", subTotal:Float) {
        self.coupon = coupon
        self.subTotal = subTotal
    }
    init()
    {
        self.coupon = ""
        subTotal = 0.0
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
    func calculateTotalPrice()->Float    {
        switch coupon
        {
        case Coupon.thirtyPercent.rawValue:
//            let discount = subTotal * 0.3
//               let discountedPrice = subTotal - discount
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
        CurrencyManager.exchangePrice(to: currencyCode) {
            exchangeRate in
            let floatValue: Float = self.subTotal * exchangeRate
            let formattedString = String(format: "%.2f", floatValue)
            self.subTotalString = "\(formattedString)\(currencyCode)"
            self.totalString = String(format: "%.2f", self.calculateTotalPrice()*exchangeRate) + "\(currencyCode)"
            self.disscountString = String(format: "%.2f", self.calculateDisscount()*exchangeRate) + "\(currencyCode)"
           self.observable.value = true
            
        }

    }
    
    enum Coupon:String{
        case thirtyPercent = "7t65dehbj874"
        case twentyPersent = "rfrkj893nmn4"
        case fiftyPersent = "498ojf84jw3s"
        case fifteenPercent = "tj99484r87u1"
    }

}
