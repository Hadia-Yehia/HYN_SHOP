//
//  ProductInfoViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 06/06/2023.
//

import UIKit

class ProductInfoViewController: UIViewController {
    @IBOutlet weak var imgsCollectionView: UICollectionView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var imgsPageControl: UIPageControl!
    let starRatingView = JStarRatingView(frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 50)), rating: 3.5, color: UIColor.systemOrange, starRounding: .roundToHalfStar)
    let viewModel = ProductInfoViewModel(productId: 8348491710749)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
       // viewModel.getProductInfo()
    }
    func bindViewModel(){
        viewModel.isLoading.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            
            DispatchQueue.main.async {
                if isLoading{
                    
                }else{
                    self.productName.text = self.viewModel.getProductName()
                    self.productDesc.text = self.viewModel.getProductDescription()
                    self.productPrice.text = self.viewModel.getProductPrice()
                }
            }
        }
    }


}
