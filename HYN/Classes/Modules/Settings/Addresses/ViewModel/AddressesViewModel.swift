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
    
     var subTotal:Float
 
     init(subTotal:Float)
     {
         self.subTotal = subTotal
 
     }
    init()
    {
        subTotal = 0.0

    }
    
    func getAddresses()
    {
        if observable.value ?? true{
            return
        }
        observable.value = true
        NetworkService.sharedInstance.getCustomerAddresses()
        {
            result in
            do {
                self.addressesArray = try result.get().addresses
                print("\(try result.get().addresses.count)")
                self.observable.value = false
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
    
    func deleteAddress(index:Int,completionHandler: @escaping ((String,String)) -> Void)
    {
        observable.value = true
       // AddressesCoreData.shared.deleteData(address: addressesArray[index])
        NetworkService.sharedInstance.deleteAddressFromServer(addressId:addressesArray[index].id ?? 0)
        {
            result in
            switch result {
               case .success(let response):
                   // Handle successful response with empty response data
                   if response == EmptyResponse() {
                       self.addressesArray.remove(at: index)
                       self.observable.value = false
                       completionHandler(("Success","Item deleted successfully"))
                   } else {
                       // Non-empty response
                   }
            case .failure(let error):
                print(error.localizedDescription)
                self.observable.value = false
                completionHandler(("Failure","Can't delete default address"))
                break
           
               }
  
            
            
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
    func navigateToPaymentOptionsViewModel(index:Int)->PaymentOptionsViewModel
        {
            return PaymentOptionsViewModel(subTotal: subTotal,address: getAddress(index: index))
        }
}
