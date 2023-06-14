//
//  PaymentViewController.swift
//  HYN
//
//  Created by Yousra Mamdouh Ali on 13/06/2023.
//

import UIKit

class PaymentViewController: UIViewController {
var viewModel = PaymentViewModel()
    @IBAction func placeOrderButton(_ sender: UIButton) {
    }
    @IBOutlet weak var lotalLabel: UILabel!
    @IBOutlet weak var disscountLabel: UILabel!
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var shippingFeesLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       setFinalCheckout()
     
        // Do any additional setup after loading the view.
    }

func setFinalCheckout()
    {
    
        couponLabel.text = viewModel.setDisscountCoupon()
        let subTotalString = subTotalLabel.text
        lotalLabel.text = viewModel.calculateTotalPrice(subTotal: Float(subTotalString!)!)
        disscountLabel.text = viewModel.calculateDisscount(subTotal: Float(subTotalString!)!)

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
