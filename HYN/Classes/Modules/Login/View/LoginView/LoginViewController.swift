//
//  LoginViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.backItem?.setHidesBackButton(true, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        passwordTF.setBoarder()
        emailTF.setBoarder()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }

    @IBAction func googleBtn(_ sender: UIButton) {
        signInWithGoogle()
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
                  
                    
                    print("fav id \(UserDefaults.standard.object(forKey: "favId") as! Int)")
                    print("cart id \(UserDefaults.standard.object(forKey: "cartId") as! Int)")
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
    func signInWithGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
              print(error as Any)
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in
                if let name = result?.user.displayName, let email = result?.user.email, let password  = result?.user.uid  {
                    let customer = Customer(first_name: name, last_name: "", email: email, phone: nil, verified_email: true, password: password, password_confirmation: password, send_email_welcome: true)
                    self.viewModel.signInWithGoogle(customer: customer, completionHandler: {result in
                        switch result{
                        case .success(_):
                            break
                        case .failure(let error):
                            print(error)
                            break
                        }
                    })
                    let homeVC = TabBar()
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
                else {
                    Toast.show(message: "missing data", controller: self)
                }
              
                
                
            }
                
        }
    }
    
        
    
}
