//
//  SettingsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    let defaults = UserDefaults.standard
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
    @IBAction func logoutBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.defaults.setValue(false, forKey: "logged in")
                print(self.defaults.bool(forKey: "logged in"))
                let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                self.navigationController?.pushViewController(loginVC, animated: true)
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
                                     ))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        
    }
}
