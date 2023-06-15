//
//  HomeViewController.swift
//  HYN
//
//  Created by Nada youssef on 07/06/2023.
//

import UIKit
import SDWebImage
class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {

    var timer : Timer?
    var currentAdIndex = 0
   
    
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
       
        searchBar.delegate = self

        brandsCollection.register(UINib(nibName: "MadiaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mediaCell")
        // Do any additional setup after loading the view.
        print("nada")
       mediaCollection.dataSource = self
        mediaCollection.delegate = self
        brandsCollection.dataSource = self
        brandsCollection.delegate = self
        mediaCollection.register(UINib(nibName: "MadiaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mediaCell")
        
        viewModel.getbrandData()
        controlMedia.numberOfPages = viewModel.getAdsArrayCount()
        startTimer()
        

      
    }
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
       
    }
    @objc func moveToNextIndex()
    {
        if currentAdIndex < viewModel.getAdsArrayCount() - 1
        {
            currentAdIndex += 1
     
        }else
        {
            currentAdIndex = 0
        }
        mediaCollection.scrollToItem(at: IndexPath(item: currentAdIndex, section: 0), at: .centeredHorizontally, animated: true)
        controlMedia.currentPage = currentAdIndex
   
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
          //  return photoCell.count
            return viewModel.getAdsArrayCount()
         default:
            return viewModel.getBrandsCount()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case brandsCollection:
            
            let detailsVC = BrandViewController(nibName: "BrandViewController", bundle: nil)
           let id = self.viewModel.navigateToBrandView(index: indexPath.row)
            detailsVC.viewModel = self.viewModel.navigateToBrandView(index: indexPath.row)
            navigationController?.pushViewController(detailsVC, animated: true)
            break
            
        case mediaCollection:
     UIPasteboard.general.string =  viewModel.getAd(index: indexPath.row).coupon
            Toast.show(message: "Congrates! Coupon copied to clipboard successfully", controller: self)
            break
        default:
            break
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
           cell.photoView.image = UIImage(named: viewModel.getAd(index: indexPath.row).image)
           cell.mediaView.contentMode = .scaleAspectFill
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case mediaCollection:
            return CGSize(width: mediaCollection.frame.width, height: mediaCollection.frame.height)
        default:
            return CGSize(width: mediaCollection.frame.width/2 - mediaCollection.frame.width/2*0.1, height: mediaCollection.frame.height/3)
        }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView
        {
        case mediaCollection:
            return 0
        default:
            return 50
            
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
        brandsCollection.reloadData()
    }


}
