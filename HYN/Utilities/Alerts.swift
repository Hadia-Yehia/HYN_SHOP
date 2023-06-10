//
//  Alerts.swift
//  SportsHub
//
//  Created by Yousra Mamdouh Ali on 25/05/2023.
//

import UIKit

class Alerts {
    static func makeConfirmationDialogue(message: String) {
        let alertController = UIAlertController(title: "Confirmation", message: message, preferredStyle: .alert)
        
   
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
      
        }
        
        alertController.addAction(confirmAction)

        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
   
}
