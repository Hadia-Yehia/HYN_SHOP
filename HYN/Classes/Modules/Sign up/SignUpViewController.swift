//
//  SignUpViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 10/06/2023.
//

import UIKit
//import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
//    var customer : CustomerRequest?
//    let viewModel = SignUpViewModel()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = false
//
//        // Do any additional setup after loading the view.
//    }
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        hidesBottomBarWhenPushed = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @IBAction func skipBtn(_ sender: UIButton) {
//        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
//        navigationController?.pushViewController(homeVC, animated: true)
//    }
//    @IBAction func signUpBtn(_ sender: UIButton) {
//        if let firstName = firstNameTF.text, let lastName = lastNameTF.text, let phone = phoneTF.text , let email = emailTF.text , let password = passwordTF.text , let confirmPassword = confirmPassTF.text{
//            if password == confirmPassword{
//                let customer = Customer(first_name: firstName, last_name: lastName, email: email, phone: phone, verified_email: false, password: password, password_confirmation: confirmPassword, send_email_welcome: true)
//                let result = viewModel.rigesterNewCustomer(customer: customer)
//                switch result {
//                case "success":
//                    let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
//                    self.navigationController?.pushViewController(homeVC, animated: true)
//                    break
//                default:
//                    Toast.show(message: result, controller: self)
//                    break
//                }
//            }else{
//                Toast.show(message: "Password doesn't match", controller: self)
//            }
//           
//        }else {
//            Toast.show(message: "All fields must be filled", controller: self)
//        }
//    }
//    
    @IBAction func signInBtn(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
