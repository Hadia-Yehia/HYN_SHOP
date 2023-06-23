//
//  PaymentOptionsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit
import PassKit

class PaymentOptionsViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
    }
    
    
    
    let controller = PKPaymentAuthorizationController()
    var isApplePayButtonSelected:Bool = false
    var isCashButtonSelected:Bool = false
    var viewModel = PaymentOptionsViewModel()
    @IBOutlet weak var confirmCheckoutButoon: UIButton!
    @IBAction func ConfirmCheckoutButton(_ sender: UIButton) {
        if let text = couponField.text, !text.isEmpty && (isCashButtonSelected||isApplePayButtonSelected) {
            
            if Coupon(rawValue: couponField.text ?? "") != nil {
             
              
              
                    let paymentViewController = PaymentViewController()
                    paymentViewController.viewModel = self.viewModel.navigateToPayment(coupon: couponField.text ?? "1",isCashSelected: isCashButtonSelected)
                    navigationController?.pushViewController(paymentViewController, animated: true)
                
               
            } else {
                Alerts.makeConfirmationDialogue(title: "Not Valid Coupon!", message: "Please enter a valid coupon")
            }
           
        } else if !(isCashButtonSelected||isApplePayButtonSelected){
            Alerts.makeConfirmationDialogue(title: "No Payment method!", message: "Please choose payment method")
        }
        else
        {
            let alertController =  Alerts.showAlert(title: "Don't miss discounts", message: "Are you sure you want to continue without using coupon?", confirmTitle: "Yes", cancelTitle: "No",confirmHandler: {
     
                let paymentViewController = PaymentViewController()
                paymentViewController.viewModel = self.viewModel.navigateToPayment(coupon: self.couponField.text ?? "1", isCashSelected: self.isCashButtonSelected)
                self.navigationController?.pushViewController(paymentViewController, animated: true)
            }, cancelHandler:
                                                        {
           return
            })

            if let topController = UIApplication.shared.keyWindow?.rootViewController {
                topController.present(alertController, animated: true, completion: nil)
            }
        }
      
    }
    @IBOutlet weak var couponField: UITextField!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var applePayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      applePayButton.addTarget(self, action: #selector(selectApplePayButton(sender:)), for: .touchUpInside)
      cashButton.addTarget(self, action: #selector(selectCashButton(sender:)), for: .touchUpInside)
       
        confirmCheckoutButoon.setRoundedCorners(radius: 5)
        couponField.setBoarder()
        // Do any additional setup after loading the view.
    }

 
    @objc func selectApplePayButton(sender: UIButton) {
        if !isApplePayButtonSelected {
            applePayButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            isApplePayButtonSelected = true
            
            // Unselect the cash button
            if isCashButtonSelected {
                cashButton.setImage(UIImage(systemName: "circle"), for: .normal)
                isCashButtonSelected = false
            }
        }
    }

    @objc func selectCashButton(sender: UIButton) {
        if !isCashButtonSelected {
            cashButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            isCashButtonSelected = true
            
            // Unselect the apple pay button
            if isApplePayButtonSelected {
                applePayButton.setImage(UIImage(systemName: "circle"), for: .normal)
                isApplePayButtonSelected = false
            }
        }
    }
    

}
