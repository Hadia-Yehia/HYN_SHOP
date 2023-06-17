//
//  LoginViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func forgotPassBtn(_ sender: UIButton) {
        let resetVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        navigationController?.pushViewController(resetVC, animated: true)
    }
    @IBAction func skipBtn(_ sender: UIButton) {
        let homeVC = TabBar()
        navigationController?.pushViewController(homeVC, animated: true)
    }
    @IBAction func signupBtn(_ sender: UIButton) {
        let signupVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(signupVC, animated: true)
        
    }
    @IBAction func signinBtn(_ sender: UIButton) {
        if let email = emailTF.text , let password = passwordTF.text{
            viewModel.signIn(email: email, password: password, completionHandler: {result in
                switch result{
                case .success(_):
                    //MARK: mo2akatan 
                    self.viewModel.getDraftCartItems(draftOrderId:UserDefaults.standard.object(forKey: "cartId") as! Int )
                    self.viewModel.getDraftFavoriteItems(draftOrderId: UserDefaults.standard.object(forKey: "favId") as! Int)
                     let homeVC = TabBar()
                     self.navigationController?.pushViewController(homeVC, animated: true)
                    
                    break
                case .failure(let error):
                    Toast.show(message: error.localizedDescription, controller: self)
                    break
                }
            })
        }
     
    }
}
