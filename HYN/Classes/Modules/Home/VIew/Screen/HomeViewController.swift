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
    var photoCell = [UIImage(named: "media3.jpg"),UIImage(named: "media1.jpg"),UIImage(named: "media2.jpg"),UIImage(named: "media.jpg")]
    override func viewDidLoad() {
        super.viewDidLoad()
     
        brandsCollection.register(UINib(nibName: "MadiaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mediaCell")
        // Do any additional setup after loading the view.
        print("nada")
       mediaCollection.dataSource = self
        mediaCollection.delegate = self
        brandsCollection.dataSource = self
        brandsCollection.delegate = self
        mediaCollection.register(UINib(nibName: "MadiaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mediaCell")
   
        var urlTeam =
            "https://3ec4212c45d4957fa3a49ab23d83ff1b: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@mad34-alex-ios-team2.myshopify.com/admin/api/2023-04/smart_collections.json"
              var url = URL(string: urlTeam)
              let request = URLRequest(url: url!)
              let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                // handle error
                print("error")
                return
            }
            guard let data = data else {
                // handle empty response
                print("empty data")
                return
            }
            do {
               // decode the response data using your model
               let result = try JSONDecoder().decode(SmartCollectionsResult.self, from: data)
                print(data.count)
                var brandObj = String()
                if let collections = result.smart_collections {
                    var i = 0
                    for collection in collections {
                        //print(collection.image?.src)
                        brandObj = (collection.image?.src)!
                        i = i+1
                        self.brandArray.append(brandObj)
                    }
                     DispatchQueue.main.async {
                         self.mediaCollection.reloadData()
                         self.brandsCollection.reloadData()
                        
                     }
                }
              } catch {
                  // handle decoding error
                  print("no dataaaaa")
                  print("Error decoding response data: \(error)")
              }
       
            // handle response data here
            // for example, you can decode the JSON data using Codable
            
        }

        task.resume()
      
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(collectionView){
        case mediaCollection:
            return photoCell.count
         default:
            return brandArray.count
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
           // cell.photoView.image = photoCell[indexPath.row]
        //   if(brandArray[indexPath.row] != nil){
               let url = URL(string: brandArray[indexPath.row])
               cell.photoView?.sd_setImage(with: url,completed: nil)
           /*    } else {
                   cell.photoView?.image = UIImage(named: "photo1.jpeg")
               }*/
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
