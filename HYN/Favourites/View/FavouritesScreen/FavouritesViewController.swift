//
//  FavouritesViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBAction func startExploringBtn(_ sender: UIButton) {
        let detailsVC = ProductInfoViewController(nibName: "ProductInfoViewController", bundle: nil)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
//        NetworkService.getInstance().fetchingProductDetails(product_id:632910392,completionHandler: {result in
//            switch result{
//            case .success(let data):
//                print("hadia" + (data.product?.bodyHtml ?? "no data"))
//                break
//            case .failure(let error):
//                print ("error "+error.localizedDescription)
//                break
//
//            }
//     })

    }


}
