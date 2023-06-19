//
//  SettingsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    let viewModel = SettingsViewModel()
    @IBAction func logoutButton(_ sender: UIButton) {
        
    }
    
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
        logoutButton.setRoundedCorners(radius: 10)
        
        
    }
    @IBAction func logoutBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.viewModel.logout(completionHandler: {result in
                switch result{
                case .success(_):
                    self.tabBarController?.tabBar.isHidden = true
                            self.tabBarController?.hidesBottomBarWhenPushed = true
                    let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    self.navigationController?.pushViewController(loginVC, animated: true)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            })
        }
                                     ))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        
    }
      
        
}
