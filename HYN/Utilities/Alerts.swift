//
//  Alerts.swift
//  SportsHub
//
//  Created by Yousra Mamdouh Ali on 25/05/2023.
//

import UIKit

class Alerts {
    static func makeConfirmationDialogue(title:String,message: String) {
        let alertController = UIAlertController(title:title , message: message, preferredStyle: .alert)
        
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            
        }
        
        alertController.addAction(confirmAction)
        
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.present(alertController, animated: true, completion: nil)
        }
    }
        
    static func showAlert(title: String, message: String, confirmTitle: String, cancelTitle: String, confirmHandler: (() -> Void)? = nil, cancelHandler: (() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirmHandler?()
        }
<<<<<<< HEAD
        confirmAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            cancelHandler?()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        return alertController
    }
=======
    static func presentTextFieldAlert(loginVC : UIViewController) -> String{
        var phone = ""
        let alertController = UIAlertController(title: "Enter Text", message: nil, preferredStyle: .alert)
        
        // Add a text field to the alert controller
        alertController.addTextField { textField in
            textField.placeholder = "Enter your text"
        }
        
        // Create the action for handling the text input
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Retrieve the text from the text field
            if let textField = alertController.textFields?.first,
               let enteredText = textField.text {
                // Handle the entered text
                phone = enteredText
                print("Entered text: \(enteredText)")
            }
        }
        
        // Add the action to the alert controller
        alertController.addAction(okAction)
        
        // Present the alert controller
        loginVC.present(alertController, animated: true)
//        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
//            viewController.present(alertController, animated: true, completion: nil)
       // }
        return phone
    }

>>>>>>> signup_with_google
    }
    
    
    
    
    
    
    
    
    
    
    
    
   

