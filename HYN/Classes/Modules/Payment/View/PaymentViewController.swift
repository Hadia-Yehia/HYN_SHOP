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
  bindingViewModel()
        subTotalLabel.text = String(viewModel.subTotal)
     
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.checkCurrency()
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
                if isLoading
                {
                    self.setFinalCheckout()
                  
                }
            }

        }
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
