//
//  PaymentOptionsViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 07/06/2023.
//

import UIKit

class PaymentOptionsViewController: UIViewController {

    let viewModel = PaymentOptionsViewModel()
    @IBAction func ConfirmCheckoutButton(_ sender: UIButton) {
        if (couponField.text == nil)
        {
            
        }
        else
        {
            let paymentViewController = PaymentViewController()
            paymentViewController.viewModel = self.viewModel.navigateToPayment(coupon: couponField.text ?? "1")
            navigationController?.pushViewController(paymentViewController, animated: true)
        }
    }
    @IBOutlet weak var couponField: UITextField!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var applePayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
