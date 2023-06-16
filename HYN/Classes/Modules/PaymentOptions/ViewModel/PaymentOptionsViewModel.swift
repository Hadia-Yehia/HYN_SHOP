//
//  PaymentOptionsViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 13/06/2023.
//

import Foundation
class PaymentOptionsViewModel{

   
    var subTotal:Float
    var address:Address?
    init(subTotal:Float,address:Address)
    {
        self.subTotal = subTotal
        self.address = address
    }
    init()
    {
        subTotal = 0.0
        address = nil
    }

    func navigateToPayment(coupon:String)-> PaymentViewModel
    {
        return PaymentViewModel(coupon: coupon,subTotal: subTotal, address:address!)
    }
  
}


