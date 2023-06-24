//
//  PaymentViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 13/06/2023.
//

import UIKit
import PassKit
class PaymentViewController: UIViewController {
 
    
    @IBOutlet weak var placeOrderButton: UIButton!
    var viewModel = PaymentViewModel()
    @IBAction func placeOrderButton(_ sender: UIButton) {
        if (Availability.isConnectedToInternet){
            
            
            
            if !(viewModel.isCashSelected ?? false)
            {
                viewModel.purchasesingApplePay()
                {
                    result in
                    let paymentAuthorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: result)
                    paymentAuthorizationViewController?.delegate = self
                    if let paymentAuthorizationViewController = paymentAuthorizationViewController {
                        self.present(paymentAuthorizationViewController, animated: true, completion: nil)
                    }
                }
                
             
            }
            
            else
            {
                
               checkMaximumPrice()
                
            }
            //my code
            self.viewModel.saveOrder()
            
            
            
            

           }
     else{
               let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(alert, animated: true, completion: nil)
           }
    }
    @IBOutlet weak var lotalLabel: UILabel!
    @IBOutlet weak var paymentMethodField: UILabel!
    @IBOutlet weak var disscountLabel: UILabel!
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var shippingFeesLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        subTotalLabel.text = String(viewModel.subTotal)
        placeOrderButton.setRoundedCorners(radius: 5)
     
        // Do any additional setup after loading the view.
    }
func confirmCheckout()
    {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        bindingViewModel()
        viewModel.checkCurrency()
        paymentMethodField.text = viewModel.isCashSelected ?? true ? "Cash" : "Apple Pay"
     //   print("final: \(viewModel.coupon) \(viewModel.subTotal) \(viewModel.address)")
      
    }

func setFinalCheckout()
    {
    
        couponLabel.text = viewModel.setDisscountCoupon()
        lotalLabel.text = viewModel.totalString
        disscountLabel.text = viewModel.disscountString
        subTotalLabel.text = viewModel.subTotalString
        shippingFeesLabel.text = "0.0\(UserDefaults.standard.string(forKey: "currencyCode") ?? "USD")"

    }
    
    func bindingViewModel()
    {
        viewModel.observable.bind {
            [weak self]
            result in
            guard let self = self ,  let isLoading = result
                    else
            {
                return
            }

            DispatchQueue.main.async {
                if !isLoading
                {
                    self.setFinalCheckout()
                  
                }
            }

        }
    }
    func checkMaximumPrice()
    {
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        switch currencyCode
        {
        case "EGP":
            if viewModel.calculateTotalPrice() > 30000
            {
                
            }
            else
            {
                navigationController?.pushViewController(PurchacingViewController(), animated: true)
            }
        case "EUR" , "USD":
            if viewModel.calculateTotalPrice() > 3000
            {
                
            }
            else
            {
                navigationController?.pushViewController(PurchacingViewController(), animated: true)
            }
        case "AMD", "AED":
            if viewModel.calculateTotalPrice() > 20000
            {
                
            }
            else
            {
                navigationController?.pushViewController(PurchacingViewController(), animated: true)
            }
        default:
            return
        }
    }


}
extension PaymentViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
       // print("success")
        navigationController?.pushViewController(PurchacingViewController(), animated: true)
        let result = PKPaymentAuthorizationResult(status: .success, errors: nil)
        completion(result)
    }
}
