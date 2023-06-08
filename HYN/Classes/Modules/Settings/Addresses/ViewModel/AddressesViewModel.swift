//
//  AddressesViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

class AddressesViewModel {
    var addressesArray:[Address] = []

    func getAddresses()
    {
      addressesArray =  AddressesCoreData.shared.getAddresses()
    }
    
    func getAddressesArrayCount()->Int
    {
        addressesArray.count
    }
    func getAddress(index:Int)->Address
    {
        addressesArray[index]
    }
    
}
