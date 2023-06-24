//
//  SignUpViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 10/06/2023.
//

import UIKit
import Firebase
import Lottie
class SignUpViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var passwordValidation: UILabel!
    @IBOutlet weak var confirmPasswordValidation: UILabel!
    private var animationView = LottieAnimationView(name: "Loading")
    let defaults = UserDefaults.standard
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    var customer : CustomerRequest?
    let viewModel = SignUpViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setFieldsStyle()
        passwordTF.delegate = self
        confirmPassTF.delegate = self
        animationView.loopMode = .loop
                animationView.contentMode = .scaleAspectFit
                animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
                animationView.center = view.center
                view.addSubview(animationView)
        animationView.isHidden = true
        //bindViewModel()
        // Do any additional setup after loading the view.
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    func setFieldsStyle()
    {
        confirmPassTF.setBoarder()
        passwordTF.setBoarder()
        emailTF.setBoarder()
        phoneTF.setBoarder()
        lastNameTF.setBoarder()
        firstNameTF.setBoarder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func skipBtn(_ sender: UIButton) {
        let homeVC = TabBar()
        navigationController?.pushViewController(homeVC, animated: true)

    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        if Availability.isConnectedToInternet{
            guard let firstName = firstNameTF.text, let lastName = lastNameTF.text, let phone = phoneTF.text , let email = emailTF.text , let password = passwordTF.text , let confirmPassword = confirmPassTF.text else{
                Toast.show(message: "All fields must be filled", controller: self)
                return
            }
            if password == confirmPassword{
                if validator(pass: password){
                    let customer = Customer(first_name: firstName, last_name: lastName, email: email, phone: phone, verified_email: false, password: password, password_confirmation: confirmPassword, send_email_welcome: true)
                    self.viewModel.rigesterNewCustomer(customer: customer,completionHandler: {
                        result in
                        switch result{
                        case .success(_):
                            self.defaults.setValue(true, forKey: "logged in")
                            print(self.defaults.bool(forKey: "logged in"))
                            let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                            self.navigationController?.pushViewController(loginVC, animated: true)
                            break
                        case .failure(let error):
                            print("signup error\(error.localizedDescription)")
                            Toast.show(message: error.localizedDescription, controller: self)
                            break
                        }
                    })
                    self.viewModel.isLoading.bind{[weak self] isLoading in
                        guard let self = self , let isLoading = isLoading
                        else{return}
                        
                        DispatchQueue.main.async {
                            if isLoading{
                                self.animationView.isHidden = false
                                self.animationView.play()
                            }else{
                                self.animationView.isHidden = true
                                self.animationView.stop()
                            }
                        }
                    }
                }
            }
        }else{
            Alerts.makeConfirmationDialogue(title: "Network issue", message: "Check your network connection and try again")
        }
    }
    
    @IBAction func signInBtn(_ sender: UIButton) {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(loginVC, animated: true)
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
            if textField == passwordTF {
                validatePassword(passwordTF.text ?? "")
            }else if textField == confirmPassTF {
                validateConfirmPassword(pass: passwordTF.text ?? "", confirm: confirmPassTF.text ?? "")
            }
        }

    func validateConfirmPassword(pass:String,confirm:String){
        var errorMessages: [String] = []
        if pass == confirm{
            errorMessages.append("Password matches")
            confirmPasswordValidation.textColor = .green
        }
        else{
            errorMessages.append("Password doesn't match")
            confirmPasswordValidation.textColor = .red
        }
        confirmPasswordValidation.text = errorMessages.joined(separator: "\n")
    }
        
        func validatePassword(_ password: String) {
            
            let uppercaseRegex = ".*[A-Z]+.*" // Regex pattern for at least one uppercase letter
            let lowercaseRegex = ".*[a-z]+.*" // Regex pattern for at least one lowercase letter
            
            let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex)
            let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", lowercaseRegex)
            
            let hasUppercase = uppercasePredicate.evaluate(with: password)
            let hasLowercase = lowercasePredicate.evaluate(with: password)
            
            var errorMessages: [String] = []
            
            if password.count < 8 {
                errorMessages.append("Password must be at least 8 characters long.")
                passwordValidation.textColor = .red
            }
            
            if !hasUppercase {
                errorMessages.append("Password must contain uppercase letter.")
                passwordValidation.textColor = .red
            }
            
            if !hasLowercase {
                errorMessages.append("Password must contain lowercase letter.")
                passwordValidation.textColor = .red
            }
            if password.count>=8 && hasLowercase && hasUppercase {
                errorMessages.append("Strong password")
                passwordValidation.textColor = .green
            }
            
            passwordValidation.text = errorMessages.joined(separator: "\n")
        }
    func validator (pass: String)-> Bool{
        let uppercaseRegex = ".*[A-Z]+.*" // Regex pattern for at least one uppercase letter
        let lowercaseRegex = ".*[a-z]+.*" // Regex pattern for at least one lowercase letter
        
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex)
        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", lowercaseRegex)
        
        let hasUppercase = uppercasePredicate.evaluate(with: pass)
        let hasLowercase = lowercasePredicate.evaluate(with: pass)
        if pass.count>=8 && hasLowercase && hasUppercase{
            return true
        }
        return false
    }
    }
