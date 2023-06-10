//
//  CategoryViewController.swift
//  HYN
//
//  Created by Nada youssef on 09/06/2023.
//

import UIKit

class CategoryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    

    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var typeCollection: UICollectionView!
    var photoCell = [UIImage(named: "media3.jpg"),UIImage(named: "media1.jpg"),UIImage(named: "media2.jpg"),UIImage(named: "media.jpg")]
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        typeCollection.register(UINib(nibName: "TypeCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "typeCell")
        productCollection.dataSource = self
        productCollection.delegate = self
        typeCollection.dataSource = self
        typeCollection.delegate = self
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch(collectionView) {
            case typeCollection:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! TypeCategoryCollectionViewCell
             cell.typeView.layer.cornerRadius = 40
             cell.layer.masksToBounds = true
            cell.typeImage.image = photoCell[indexPath.row]
            cell.typeLabel.text = "nada"
           
             return cell
             
           default :
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
             cell.productView.layer.cornerRadius = 40
             cell.layer.masksToBounds = true
             cell.productImage.image = photoCell[indexPath.row]
             cell.productLabel.text = "youssef"
         
             return cell
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width:collectionView.bounds.width/2, height: collectionView.bounds.height/2)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case productCollection:
            let detailsVC = ProductInfoViewController(nibName: "ProductInfoViewController", bundle: nil)
            navigationController?.pushViewController(detailsVC, animated: true)
            break
        default:
            break
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
