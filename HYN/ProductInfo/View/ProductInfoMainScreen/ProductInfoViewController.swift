//
//  ProductInfoViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 06/06/2023.
//

import UIKit

class ProductInfoViewController: UIViewController {
    let starRatingView = JStarRatingView(frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 50)), rating: 3.5, color: UIColor.systemOrange, starRounding: .roundToHalfStar)
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
