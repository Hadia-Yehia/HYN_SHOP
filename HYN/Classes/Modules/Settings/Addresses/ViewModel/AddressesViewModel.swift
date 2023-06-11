//
//  AddressesViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

class AddressesViewModel {
    var observable: Observable <Bool> = Observable(false)
    var addressesArray:[testAddress] = []

    func getAddresses()
    {
        observable.value = false
      addressesArray =  AddressesCoreData.shared.getAddresses()
        observable.value = true
    }
    
    func getAddressesArrayCount()->Int
    {
        addressesArray.count
    }
    
    func getAddress(index:Int)->testAddress
    {
        addressesArray[index]
    }
    
    func deleteAddress(index:Int)
    {
        AddressesCoreData.shared.deleteData(address: addressesArray[index])
        self.addressesArray.remove(at: index)
        observable.value = true
    }
    
    func isAddressesTableEmpty()-> Bool
    {
        if addressesArray.isEmpty
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func editAddress(index :Int) -> AddAddressViewModel
    {
        let address = addressesArray[index]
        return AddAddressViewModel(address: address)
    }
}
