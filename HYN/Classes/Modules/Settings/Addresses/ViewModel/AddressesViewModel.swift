//
//  AddressesViewModel.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 08/06/2023.
//

import UIKit

class AddressesViewModel {
    var observable: Observable <Bool> = Observable(false)
    var addressesArray:[Address] = []

    func getAddresses()
    {
        observable.value = false
        NetworkService.sharedInstance.getCustomerAddresses()
        {
            result in
            do {
                self.addressesArray = try result.get().addresses
                print("\(try result.get().addresses.count)")
                self.observable.value = true
            } catch {
                print("Error caught: \(error)")
            }
           
        }
     // addressesArray =  AddressesCoreData.shared.getAddresses()
       
    }
    
    func getAddressesArrayCount()->Int
    {
        addressesArray.count
    }
    
    func getAddress(index:Int)->Address
    {
        addressesArray[index]
    }
    
    func deleteAddress(index:Int)
    {
        observable.value = false
       // AddressesCoreData.shared.deleteData(address: addressesArray[index])
        NetworkService.sharedInstance.deleteAddressFromServer(addressId:addressesArray[index].id ?? 0)
        {
            result in
            self.addressesArray.remove(at: index)
            self.observable.value = true
        }
      
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
