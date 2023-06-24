//
//  SettingsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    let appDelegate = UIApplication.shared.windows.first
    let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var logoutButton: UIButton!
    let viewModel = SettingsViewModel()
    @IBAction func logoutButton(_ sender: UIButton) {
        
    }
    
    @IBAction func darkmodeSwitch(_ sender: UISwitch) {
        if #available(iOS 13, *) {
              
                if sender.isOn {
                    appDelegate?.overrideUserInterfaceStyle = .dark
                } else {
                    appDelegate?.overrideUserInterfaceStyle = .light
                }
                
                // Save the switch state in user defaults
              //  UserDefaults.standard.set(sender.isOn, forKey: "darkModeEnabled")
            } else {
                // Fallback for earlier versions of iOS
            }
    }
    let defaults = UserDefaults.standard
    
    @IBAction func addressesButton(_ sender: UIButton) {
        let destinationViewController = AddressesViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    @IBAction func aboutButton(_ sender: UIButton) {
        navigationController?.pushViewController(AboutUsViewController(), animated: true)
    }
    @IBAction func contactUsButton(_ sender: UIButton) {
        navigationController?.pushViewController(ContactUsViewController(), animated: true)
    }
    @IBAction func currencyButton(_ sender: UIButton) {
        navigationController?.pushViewController(CurrencyViewController(), animated: true)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.setRoundedCorners(radius: 10)
       // `switch`.addTarget(self, action: #selector(darkmodeSwitch(_:)), for: .valueChanged)
 
        
        
    }
    @IBAction func logoutBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.viewModel.logout(completionHandler: {result in
                switch result{
                case .success(_):
                 
                           
                    self.appDelegate?.overrideUserInterfaceStyle = .light
                    self.tabBarController?.tabBar.isHidden = true
                            self.tabBarController?.hidesBottomBarWhenPushed = true
                    let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    self.navigationController?.pushViewController(loginVC, animated: true)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    Alerts.makeConfirmationDialogue(title: "Network issue", message: "Check your network connection and try agian")
                    break
                }
            })
        }
                                     ))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        
    }
      
        
}
