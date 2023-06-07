//
//  HomeViewController.swift
//  HYN
//
//  Created by Nada youssef on 07/06/2023.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    
    @IBOutlet weak var controlMedia: UIPageControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mediaCollection: UICollectionView!
    @IBOutlet weak var brandsCollection: UICollectionView!
    
    var photoCell = [UIImage(named: "photo1.jpeg"),UIImage(named: "photo1.jpeg"),UIImage(named: "photo1.jpeg"),UIImage(named: "photo1.jpeg")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("nada")
        mediaCollection.dataSource = self
        mediaCollection.delegate = self
        brandsCollection.dataSource = self
        brandsCollection.delegate = self
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch(collectionView) {
           case mediaCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! MadiaCollectionViewCell
            cell.mediaView.layer.cornerRadius = 40
            cell.layer.masksToBounds = true
            cell.photoView.image = photoCell[indexPath.row]
            return cell
            
          default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fristCell", for: indexPath) as! MadiaCollectionViewCell
            cell.mediaView.layer.cornerRadius = 40
            cell.layer.masksToBounds = true
            cell.photoView.image = photoCell[indexPath.row]
            return cell
        }
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
