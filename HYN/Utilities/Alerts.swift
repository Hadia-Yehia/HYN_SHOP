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
        
     static   func showAlert(title: String, message: String, confirmTitle: String, cancelTitle: String, confirmHandler: (() -> Void)? = nil, cancelHandler: (() -> Void)? = nil) -> UIAlertController {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                confirmHandler?()
            }
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelHandler?()
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            
            return alertController
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
   

