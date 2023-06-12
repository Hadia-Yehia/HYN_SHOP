//
//  LoginViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
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
    }
    @IBAction func skipBtn(_ sender: UIButton) {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        navigationController?.pushViewController(homeVC, animated: true)
    }
    @IBAction func signupBtn(_ sender: UIButton) {
        let signupVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(signupVC, animated: true)
        
    }
    @IBAction func signinBtn(_ sender: UIButton) {
        if let email = emailTF.text , let password = passwordTF.text{
            Auth.auth().signIn(withEmail: email, password: password){[weak self] authResult , error in
                guard let self = self else {return}
                if let e = error {
                    Toast.show(message: e.localizedDescription, controller: self)
                }
                else{
                    let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
        }
    }

}
