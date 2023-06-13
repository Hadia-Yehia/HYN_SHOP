//
//  ProductInfoViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 06/06/2023.
//

import UIKit

class ProductInfoViewController: UIViewController {
    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var imgsCollectionView: UICollectionView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var imgsPageControl: UIPageControl!
    let starRatingView = JStarRatingView(frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 50)), rating: 3.5, color: UIColor.systemOrange, starRounding: .roundToHalfStar)
    let reviewArray = [ReviewItem(name: "Hadia Yehia", content: "I had a wonderful experience and I would highly recommend this business to others.", rating: 3.5),ReviewItem(name: "Nada Elshafy", content: "I bought a bag from here. The quality is remarkable. It's well worth the money for their high-quality products, I highly recommended!", rating: 4.5)]
   // let viewModel = ProductInfoViewModel(productId: 8348491710749)
    var viewModel : ProductInfoViewModel?
    var descSeeMoreFlag = false
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTable()
        bindViewModel()
        setupDescLabel()
        viewModel?.getProductInfo()
        
    }
    func setupDescLabel(){
        productDesc.numberOfLines = 2
        
        //productDesc.lineBreakMode = .byWordWrapping
        productDesc.sizeToFit()
    }
    func bindViewModel(){
        viewModel?.isLoading.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            
            DispatchQueue.main.async {
                if isLoading{
                    
                }else{
                    self.productName.text = self.viewModel?.getProductName()
                    self.productDesc.text = self.viewModel?.getProductDescription()
                    self.productPrice.text = self.viewModel?.getProductPrice()
                    self.imgsPageControl.numberOfPages = self.viewModel?.getImgsCount() ?? 0
                    self.imgsCollectionView.reloadData()
                }
            }
        }
    }

    @IBOutlet weak var expandDescBtn: UIButton!
    @IBAction func expandDesc(_ sender: UIButton) {
        switch descSeeMoreFlag{
        case false:
            productDesc.numberOfLines = 0
            productDesc.sizeToFit()
            expandDescBtn.titleLabel?.text = "see less"
            descSeeMoreFlag = true
            
            break
        case true:
            productDesc.numberOfLines = 2
            productDesc.sizeToFit()
            expandDescBtn.titleLabel?.text = "see more"
            descSeeMoreFlag = false
        }
        
    }
    
}

extension ProductInfoViewController : UITableViewDelegate,UITableViewDataSource{
    
    func setupTable(){
        reviewTable.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        self.reviewTable.dataSource = self
        self.reviewTable.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        cell.configCell(review: reviewArray[indexPath.row])
        return cell
    }
    
    
}
