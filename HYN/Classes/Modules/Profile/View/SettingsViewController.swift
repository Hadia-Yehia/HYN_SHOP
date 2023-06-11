//
//  SettingsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func addressesButton(_ sender: UIButton) {
        let destinationViewController = AddressesViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    @IBAction func currencyButton(_ sender: UIButton) {
        navigationController?.pushViewController(CurrencyViewController(), animated: true)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let address = Address(address1: "123 Maint St", first_name: "John", last_name: "Doe", name: "John Doe",
//                              city: "Anytown", country: "Canada",
//                              phone: "01118703762", zip: "12465")
//        NetworkService.sharedInstance.createNewAddress(address: address)
//        {
//            result in
//    
//            print("lotfy: \(result)")
//        }
    }
}
