//
//  CategoryViewController.swift
//  HYN
//
//  Created by Nada youssef on 09/06/2023.
//

import UIKit
import Lottie

class CategoryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()

    private var animationView = LottieAnimationView(name: "Loading")
    @IBOutlet weak var searchBar: UISearchBar!
    private let floatingButton:UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemYellow
        let image = UIImage(systemName: "plus",withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var typeCollection: UICollectionView!
    var viewModel = CategoryViewModel()
    var photoCell : [CollectionStruct] =  Array()
    
    var object1 = CollectionStruct(id: 448684294429, title: "KIDS", img:  "kids2.jpg")
    var object2 = CollectionStruct(id: 448684196125, title: " MEN", img:  "man2.png")
    var object3 = CollectionStruct(id: 448684327197, title: "SALE", img:  "sale2.jpg")
    var object4 = CollectionStruct(id: 448684261661, title: "WOMEN", img:  "woman2.jpg")
   // var photoCell = [UIImage(named: "media3.jpg"),UIImage(named: "media1.jpg"),UIImage(named: "media2.jpg"),UIImage(named: "media.jpg")]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
       // self.title = "Category"
        searchBar.delegate = self
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button1.setImage(UIImage(named: "tshirt.png"), for: .normal)
        button1.backgroundColor = .white
        button1.isHidden = true
        button1.layer.cornerRadius = 30
        button1.layer.masksToBounds = true
        view.addSubview(button1)
        
        button2.setImage(UIImage(named: "accessory.jpg"), for: .normal)
        button2.backgroundColor = .white
        button2.isHidden = true
        button2.layer.cornerRadius = 30
        button2.layer.masksToBounds = true
        view.addSubview(button2)
        
        button3.setImage(UIImage(named: "shoes.png"), for: .normal)
        button3.backgroundColor = .white
        button3.isHidden = true
        button3.layer.cornerRadius = 30
        button3.layer.masksToBounds = true
        view.addSubview(button3)
        
        button4.setImage(UIImage(named: "all.jpg"), for: .normal)
        button4.backgroundColor = .white
        button4.isHidden = true
        button4.layer.cornerRadius = 30
        button4.layer.masksToBounds = true
        view.addSubview(button4)
        
       // self.bindViewModel()
        //self.bindViewModelTwo()
        //self.bindViewModelThree()
        photoCell.append(object1)
        photoCell.append(object2)
        photoCell.append(object4)
        photoCell.append(object3)
      
        productCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        typeCollection.register(UINib(nibName: "TypeCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "typeCell")
        productCollection.dataSource = self
        productCollection.delegate = self
        typeCollection.dataSource = self
        typeCollection.delegate = self
        //viewModel.getProductData()
        //viewModel.getCollectionData()
       // viewModel.getProductsForSecData(0)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if (Availability.isConnectedToInternet){
            self.bindViewModel()
            viewModel.getProductData()
        }
        else{
               let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(alert, animated: true, completion: nil)
           }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 150, width: 60, height: 60)
        
        button1.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 220, width: 60, height: 60)
        button1.addTarget(self, action: #selector(filterTshirt), for: .touchUpInside)
        
        button2.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 290, width: 60, height: 60)
        button2.addTarget(self, action: #selector(filterAcc), for: .touchUpInside)
        
        
        button3.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 360, width: 60, height: 60)
        button3.addTarget(self, action: #selector(filteShose), for: .touchUpInside)
        
        button4.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 430, width: 60, height: 60)
        button4.addTarget(self, action: #selector(noFilter), for: .touchUpInside)
    }
    @objc private func didTapButton(){
        button1.isHidden = !button1.isHidden
        button2.isHidden = !button2.isHidden
        button3.isHidden = !button3.isHidden
        button4.isHidden = !button4.isHidden
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    @objc private func filterAcc(){
        print("acc")
        if (Availability.isConnectedToInternet){
            self.viewModel.getCategoryForSecData(type: "ACCESSORIES")
        }
        else{
               let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(alert, animated: true, completion: nil)
           }
    

    }
    @objc private func filteShose(){
        print("shose")
        if (Availability.isConnectedToInternet){
            self.viewModel.getCategoryForSecData(type: "SHOES")
        }
        else{
               let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(alert, animated: true, completion: nil)
           }
  

    }
    @objc private func filterTshirt(){
        print("tshirt")
        if (Availability.isConnectedToInternet){
            self.viewModel.getCategoryForSecData(type: "T-SHIRTS")
         }
        else{
               let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(alert, animated: true, completion: nil)
           }
    }

    @objc private func noFilter(){
        print("no filter")
        if (Availability.isConnectedToInternet){
            self.viewModel.getProductData()
         }
        else{
               let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(alert, animated: true, completion: nil)
           }
    }
    func bindViewModel(){
        viewModel.isLoading.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            DispatchQueue.main.async {
                if isLoading{
                    self.animationView.isHidden = false
                    self.animationView.play()
                }else{
                    self.productCollection.reloadData()
                    self.animationView.isHidden = true
                    self.animationView.stop()
                }
            }
        }
    }
    /*func bindViewModelThree(){
        viewModel.isLoadingThree.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            DispatchQueue.main.async {
                if isLoading{
                    print("if ya eslam")
                }else{
                    print("else ya eslam")
                    self.productCollection.reloadData()

                }
            }
        }
    }*/
    /*func bindViewModelTwo(){
        viewModel.isLoadingTwo.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            DispatchQueue.main.async {
                if isLoading{
                    
                }else{
                    
                    self.typeCollection.reloadData()
                }
            }
        }
    }*/
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(collectionView){
        case typeCollection:
            return photoCell.count
         default:
            return viewModel.getProductsCount()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        switch(collectionView) {
            case typeCollection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! TypeCategoryCollectionViewCell
             cell.typeView.layer.cornerRadius = 40
             cell.layer.masksToBounds = true
            //print("in type\(viewModel.getCellTitleTypeData(index: indexPath.row))")
            print("count\(photoCell.count)")
            cell.typeImage.image = UIImage(named: photoCell[indexPath.row].img)
            cell.typeLabel.text = photoCell[indexPath.row].title
            /*cell.configCell(img: viewModel.getCellImgTypeData(index: indexPath.row), title: viewModel.getCellTitleTypeData(index: indexPath.row))*/
           
             return cell
             
           default :
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
             cell.productView.layer.cornerRadius = 40
             cell.layer.masksToBounds = true
            cell.configCell(img: viewModel.getCellImgData(index: indexPath.row), price: viewModel.getCellPriceData(index: indexPath.row), id: viewModel.getCellIdData(index: indexPath.row),name:viewModel.getCellNameData(index: indexPath.row),inventoryQuantity: viewModel.getCellInventoryQuantity(index: indexPath.row), viewC: self)
         
             return cell
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView
        {
        case typeCollection:
            return CGSize(width: collectionView.frame.size.width/4 - (0.01 * collectionView.frame.size.width), height: 100)
        default:
            return CGSize(width:collectionView.bounds.width/2 - collectionView.bounds.width/2 * 0.1, height: collectionView.bounds.height/2 - collectionView.bounds.height/2 * 0.1)
        }
      
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case productCollection:
         if (Availability.isConnectedToInternet){
                let detailsVC = ProductInfoViewController(nibName: "ProductInfoViewController", bundle: nil)
                detailsVC.viewModel = viewModel.navigateToDetails(index: indexPath.row)
                navigationController?.pushViewController(detailsVC, animated: true)
          }
         else{
                  let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(alert, animated: true, completion: nil)
              }
          
        default:
            if (Availability.isConnectedToInternet){
                self.viewModel.getProductsForSecData(brandId: photoCell[indexPath.row].id)

             }
            else{
                   let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(alert, animated: true, completion: nil)
               }
        //    self.productCollection.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
        productCollection.reloadData()
    }
    func setUpAnimation(){
        animationView.loopMode = .loop
                animationView.contentMode = .scaleAspectFit
                animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
                animationView.center = view.center
                view.addSubview(animationView)
        animationView.isHidden = true
    }

}
