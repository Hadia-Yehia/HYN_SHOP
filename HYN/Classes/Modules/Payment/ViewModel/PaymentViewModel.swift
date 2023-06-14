//
//  PaymentViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 13/06/2023.
//

import Foundation
class PaymentViewModel
{
    var coupon:String?
    init(coupon: String? = "1") {
        self.coupon = coupon
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
    func calculateTotalPrice(subTotal:Float)-> String
    {
        switch coupon
        {
        case Coupon.thirtyPercent.rawValue:
//            let discount = subTotal * 0.3
//               let discountedPrice = subTotal - discount
            return String(subTotal-subTotal*0.3)
        case Coupon.twentyPersent.rawValue:
            return String(subTotal-subTotal*0.2)
        case Coupon.fiftyPersent.rawValue:
            return String(subTotal-subTotal*0.5)
        case Coupon.fifteenPercent.rawValue:
            return String(subTotal-subTotal*0.15)
        default:
            return String(subTotal*1)


        }
    }
    func calculateDisscount(subTotal:Float)-> String
    {
        switch coupon
        {
        case Coupon.thirtyPercent.rawValue:
            return String(-subTotal*0.3)
        case Coupon.twentyPersent.rawValue:
            return String(-subTotal*0.2)
        case Coupon.fiftyPersent.rawValue:
            return String(-subTotal*0.5)
        case Coupon.fifteenPercent.rawValue:
            return String(-subTotal*0.15)
        default:
            return String(-subTotal*1)


        }

    }
    enum Coupon:String{
        case thirtyPercent = "7t65dehbj874"
        case twentyPersent = "rfrkj893nmn4"
        case fiftyPersent = "498ojf84jw3s"
        case fifteenPercent = "tj99484r87u1"
    }

}
