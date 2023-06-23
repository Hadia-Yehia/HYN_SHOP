//
//  ForgotPasswordViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 16/06/2023.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var resetEmailLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }


    @IBAction func resetBtn(_ sender: UIButton) {
    
        let auth = Auth.auth()
        if let email = resetEmailLabel.text {
            auth.sendPasswordReset(withEmail: email){ (error) in
                if let error = error{
                    let alert = UIAlertController(title: "Authentication issue", message: error.localizedDescription, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                let alert = UIAlertController(title: "Password reset", message: "A password reset email has been sent", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                      self.navigationController?.pushViewController(loginVC, animated: true)

    }
    

}
