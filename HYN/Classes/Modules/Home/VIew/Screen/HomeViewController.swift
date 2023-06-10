//
//  HomeViewController.swift
//  HYN
//
//  Created by Nada youssef on 07/06/2023.
//

import UIKit
import SDWebImage
class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    
   
    
    @IBOutlet weak var controlMedia: UIPageControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mediaCollection: UICollectionView!
    @IBOutlet weak var brandsCollection: UICollectionView!
    var brandArray : [String] = []
    var viewModel = HomeViewModel()
    var photoCell = [UIImage(named: "media3.jpg"),UIImage(named: "media1.jpg"),UIImage(named: "media2.jpg"),UIImage(named: "media.jpg")]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        brandsCollection.register(UINib(nibName: "MadiaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mediaCell")
        // Do any additional setup after loading the view.
        print("nada")
       mediaCollection.dataSource = self
        mediaCollection.delegate = self
        brandsCollection.dataSource = self
        brandsCollection.delegate = self
        mediaCollection.register(UINib(nibName: "MadiaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mediaCell")
        
        viewModel.getbrandData()
        

      
    }
    func bindViewModel(){
        viewModel.isLoading.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            
            DispatchQueue.main.async {
                if isLoading{
                    
                }else{
                    self.brandsCollection.reloadData()
                }
            }
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(collectionView){
        case mediaCollection:
            return photoCell.count
         default:
            return viewModel.getBrandsCount()
        }
       
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width:collectionView.bounds.width, height: collectionView.bounds.height)
        }*/
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // print("nadaaaaa")
        //print(brandArray[indexPath.row])
       switch(collectionView) {
           case mediaCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! MadiaCollectionViewCell
            cell.mediaView.layer.cornerRadius = 40
            cell.layer.masksToBounds = true
           cell.photoView.image = photoCell[indexPath.row]
           
           //if(brandArray[indexPath.row] != nil){
              // let url = URL(string: brandArray[indexPath.row])
              // cell.photoView?.sd_setImage(with: url,completed: nil)
             /*  } else {
                   cell.photoView?.image = UIImage(named: "photo1.jpeg")
               }*/
            return cell
            
          default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! MadiaCollectionViewCell
           cell.mediaView.layer.cornerRadius = 40
           cell.layer.masksToBounds = true
            cell.mediaView.layer.cornerRadius = 40
            cell.layer.masksToBounds = true
           cell.configCell(img: viewModel.getCellData(index: indexPath.row))
            return cell
        }
    }


}
