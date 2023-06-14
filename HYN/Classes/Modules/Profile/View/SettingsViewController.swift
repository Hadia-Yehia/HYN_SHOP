//
//  SettingsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
    }
    @IBAction func addressesButton(_ sender: UIButton) {
        let destinationViewController = AddressesViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    @IBAction func currencyButton(_ sender: UIButton) {
        navigationController?.pushViewController(CurrencyViewController(), animated: true)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
}
