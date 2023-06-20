//
//  BrandViewController.swift
//  HYN
//
//  Created by Nada youssef on 11/06/2023.
//

import UIKit

class BrandViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
  
    var viewModel : BrandViewModel?
    @IBOutlet weak var brandCollectionItems: UICollectionView!
    @IBOutlet weak var searchBrand: UISearchBar!
    var photoCell = [UIImage(named: "media3.jpg"),UIImage(named: "media1.jpg"),UIImage(named: "media2.jpg"),UIImage(named: "media.jpg")]
   // var brandArr : [ProductsStruct] = Array()
   // var collectionViewData: [ProductsStruct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.bindViewModel()
        searchBrand.delegate = self
     //   collectionViewData = viewModel!.productArr
        brandCollectionItems.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        brandCollectionItems.dataSource = self
        brandCollectionItems.delegate = self
        print("in brand view\(viewModel?.brandIdFromHome)")
       // viewModel?.getBrandProductsData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (Availability.isConnectedToInternet){
            self.bindViewModel()
            viewModel?.getBrandProductsData()
           }
        else{
               let alert = UIAlertController(title: "Network issue", message: "No connection", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               self.present(alert, animated: true, completion: nil)
           }
    }
    func bindViewModel(){
        viewModel!.isLoading.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            
            DispatchQueue.main.async { [self] in
                if isLoading{
                    
                }else{
                    //self.collectionViewData = self.viewModel!.productArr
                    self.brandCollectionItems.reloadData()
                }
            }
        }
    }
    
    @IBAction func filterPrice(_ sender: UISlider) {
        viewModel?.isFiltering = true
        viewModel?.filterArr = (viewModel?.productArr.filter { Float($0.price)! <= sender.value })!
         // collectionViewData = filteredItems
         // viewModel?.productArr = filteredItems!
            brandCollectionItems.reloadData()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ((viewModel?.isFiltering) == true){
            return (viewModel?.filterArr.count)!
        }else{
            return (viewModel?.getBrandsCount())!

        }
      //  return collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        cell.productView.layer.cornerRadius = 40
        cell.layer.masksToBounds = true
        if ((viewModel?.isFiltering) == true){
            cell.configCell(img: (viewModel?.filterArr[indexPath.row].img)!, price: (viewModel?.filterArr[indexPath.row].price)!)
            {
                collectionView.reloadData()
            }
        }
        else{
            cell.configCell(img: viewModel!.getCellImgData(index: indexPath.row), price: viewModel!.getCellPriceData(index: indexPath.row))
            {
                collectionView.reloadData()
            }
        }
       
       // cell.configCell(img: collectionViewData[indexPath.row].img, price: collectionViewData[indexPath.row].price)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.bounds.width/2 - collectionView.bounds.width/2 * 0.1, height: collectionView.bounds.height/2)
        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(searchText: searchText)
        brandCollectionItems.reloadData()
    }

}
