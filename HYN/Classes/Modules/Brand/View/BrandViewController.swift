//
//  BrandViewController.swift
//  HYN
//
//  Created by Nada youssef on 11/06/2023.
//

import UIKit

class BrandViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var filterBrand: UISlider!
    var viewModel : BrandViewModel?
    @IBOutlet weak var brandCollectionItems: UICollectionView!
    @IBOutlet weak var searchBrand: UISearchBar!
    var photoCell = [UIImage(named: "media3.jpg"),UIImage(named: "media1.jpg"),UIImage(named: "media2.jpg"),UIImage(named: "media.jpg")]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        brandCollectionItems.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        brandCollectionItems.dataSource = self
        brandCollectionItems.delegate = self
        print("in brand view\(viewModel?.brandIdFromHome)")
        viewModel?.getBrandProductsData()
        // Do any additional setup after loading the view.
    }
    func bindViewModel(){
        viewModel!.isLoading.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            
            DispatchQueue.main.async {
                if isLoading{
                    
                }else{
                    self.brandCollectionItems.reloadData()
                }
            }
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.getBrandsCount())!

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        cell.productView.layer.cornerRadius = 40
        cell.layer.masksToBounds = true
        cell.configCell(img: viewModel!.getCellImgData(index: indexPath.row), price: viewModel!.getCellPriceData(index: indexPath.row))
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width:collectionView.bounds.width/2, height: collectionView.bounds.height/2)
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
