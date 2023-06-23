//
//  ProductInfoViewController.swift
//  HYN
//
//  Created by Hadia Yehia on 06/06/2023.
//

import UIKit
import Lottie

class ProductInfoViewController: UIViewController {
    private var animationView = LottieAnimationView(name: "Loading")
    @IBAction func addToCartButton(_ sender: UIButton) {
        let auth = Availability.isLoggedIn
        if auth
        {
            if let size = size , let color = color{
                 viewModel?.insertProductInCoreData(size: size, color: color, completionHandler:{
                     result in
                     if result
                     {
                         Toast.show(message: "Product added to cart successfully", controller: self)
                     }
                     else
                     {
                         Toast.show(message: "Product already exists in cart", controller: self)
                     }
                 })
             }else{
                 let alert = UIAlertController(title: "Missing data", message: "You shoild choose your desired size and color ", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK", style: .default))
                 self.present(alert, animated: true, completion: nil)
             }
        }
        else
        {
            Alerts.makeConfirmationDialogue(title: "Not Authorized", message: "Please login so you can add products to cart and buy them!")
        }
  }
    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var imgsCollectionView: UICollectionView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var imgsPageControl: UIPageControl!
    var size: String?
    var color : String?
    var valid : Bool?
    let starRatingView = JStarRatingView(frame: CGRect(origin: .zero, size: CGSize(width: 250, height: 50)), rating: 3.5, color: UIColor.systemOrange, starRounding: .roundToHalfStar)
  
    var viewModel : ProductInfoViewModel?
    @IBOutlet weak var favBtnOutlet: UIBarButtonItem!
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
        animationView.loopMode = .loop
                animationView.contentMode = .scaleAspectFit
                animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                animationView.center = view.center
                view.addSubview(animationView)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sizeDropDown.didSelect(completion: { selectedItem, index, id in
            self.size = selectedItem
        })
        colorDropDown.didSelect(completion: { selectedItem, index, id in
            self.color = selectedItem
        })

        viewModel?.getProductInfo()
        guard let  validity = viewModel?.checkValidity() else{return}
        valid = validity
        if valid ?? false {
            favBtnOutlet.image = UIImage(systemName: "heart")
        }else{
            favBtnOutlet.image = UIImage(systemName: "heart.fill")
        }
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
                    self.animationView.play()
                }else{
                    self.productName.text = self.viewModel?.getProductName()
                    self.productDesc.text = self.viewModel?.getProductDescription()
                    self.productPrice.text = self.viewModel?.getProductPrice()
                    self.imgsPageControl.numberOfPages = self.viewModel?.getImgsCount() ?? 0
                    self.imgsCollectionView.reloadData()
                    self.animationView.stop()
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
            expandDescBtn.setTitle("see less", for: .normal)
            descSeeMoreFlag = true
            
            break
        case true:
            productDesc.numberOfLines = 2
            productDesc.sizeToFit()
            expandDescBtn.setTitle("see more", for: .normal)
            descSeeMoreFlag = false
        }
        
    }
    
    @IBAction func addToFavFromInfo(_ sender: UIBarButtonItem) {
        if Availability.isLoggedIn{
            if valid!{
                viewModel?.saveItemToDatabase()
                favBtnOutlet.image = UIImage(systemName: "heart.fill")
                valid = false
            }
            else {
                let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                    self.viewModel?.deleteItemFromFav()
                        self.viewDidAppear(true)
                }) )
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self.present(alert, animated: true, completion: nil)
            }
        }else {
            let alert = UIAlertController(title: "Not Authorized", message: "You should login to add to your favorites?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: {_ in
                let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                self.navigationController?.pushViewController(loginVC, animated: true)
            }) )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func revBtn(_ sender: Any) {
        let revVC = RevViewController(nibName: "ReviewsViewController", bundle: nil)
        navigationController?.pushViewController(revVC, animated: true)
    }
    
    @IBOutlet weak var sizeDropDown: DropDown!{
        didSet{
            viewModel?.size.bind{[weak self] arr in
                guard let self = self , let arr = arr
                else{return}
                
                DispatchQueue.main.async {
                    self.sizeDropDown.optionArray = arr
                }
            }
            self.sizeDropDown.selectedRowColor = UIColor(named:"yellow" )!
        }
    }
    
    @IBOutlet weak var colorDropDown: DropDown!{
        didSet{
            viewModel?.color.bind{[weak self] arr in
                guard let self = self , let arr = arr
                else{return}
                
                DispatchQueue.main.async {
                    self.colorDropDown.optionArray = arr
                }
            }
            self.colorDropDown.selectedRowColor = UIColor(named:"yellow" )!
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
        cell.configCell(review: viewModel?.getReviews()[indexPath.row] ?? ReviewItem(name: "", content: "", rating: 0.0))
        return cell
    }
 
   
    }
    
    
    


