//
//  CategoryViewController.swift
//  HYN
//
//  Created by Nada youssef on 09/06/2023.
//

import UIKit

class CategoryViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()

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
    
    var object1 = CollectionStruct(id: 448684294429, title: "KID", img:  "kid.jpg")
    var object2 = CollectionStruct(id: 448684196125, title: " MEN", img:  "men.png")
    var object3 = CollectionStruct(id: 448684327197, title: "SALE", img:  "sale.jpg")
    var object4 = CollectionStruct(id: 448684261661, title: "WOMEN", img:  "women.jpg")
   // var photoCell = [UIImage(named: "media3.jpg"),UIImage(named: "media1.jpg"),UIImage(named: "media2.jpg"),UIImage(named: "media.jpg")]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button1.setImage(UIImage(named: ""), for: .normal)
        button1.backgroundColor = .systemYellow
        button1.isHidden = true
        button1.layer.cornerRadius = 30
        button1.layer.masksToBounds = true
        view.addSubview(button1)
        
        button2.setImage(UIImage(named: "plus"), for: .normal)
        button2.backgroundColor = .systemYellow
        button2.isHidden = true
        button2.layer.cornerRadius = 30
        button2.layer.masksToBounds = true
        view.addSubview(button2)
        
        button3.setImage(UIImage(named: "plus"), for: .normal)
        button3.backgroundColor = .systemYellow
        button3.isHidden = true
        button3.layer.cornerRadius = 30
        button3.layer.masksToBounds = true
        view.addSubview(button3)
        
        button4.setImage(UIImage(named: "plus"), for: .normal)
        button4.backgroundColor = .systemYellow
        button4.isHidden = true
        button4.layer.cornerRadius = 30
        button4.layer.masksToBounds = true
        view.addSubview(button4)
        
        self.bindViewModel()
        //self.bindViewModelTwo()
        //self.bindViewModelThree()
        photoCell.append(object1)
        photoCell.append(object2)
        photoCell.append(object3)
        photoCell.append(object4)
        productCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        typeCollection.register(UINib(nibName: "TypeCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "typeCell")
        productCollection.dataSource = self
        productCollection.delegate = self
        typeCollection.dataSource = self
        typeCollection.delegate = self
        viewModel.getProductData()
        //viewModel.getCollectionData()
       // viewModel.getProductsForSecData(0)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 150, width: 60, height: 60)
        
        button1.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 220, width: 60, height: 60)
        button1.addTarget(self, action: #selector(filterAcc), for: .touchUpInside)
        
        button2.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 290, width: 60, height: 60)
        button2.addTarget(self, action: #selector(filteShose), for: .touchUpInside)
        
        
        button3.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 360, width: 60, height: 60)
        button3.addTarget(self, action: #selector(filterTshirt), for: .touchUpInside)
        
        button4.frame = CGRect(x: view.frame.size.width-70, y: view.frame.size.height - 360, width: 60, height: 60)
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
        
    }
    @objc private func filteShose(){
        
    }
    @objc private func filterTshirt(){
        
    }
    @objc private func noFilter(){
        
    }
    func bindViewModel(){
        viewModel.isLoading.bind{[weak self] isLoading in
            guard let self = self , let isLoading = isLoading
            else{return}
            DispatchQueue.main.async {
                if isLoading{
                }else{
                    self.productCollection.reloadData()
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
            cell.configCell(img: viewModel.getCellImgData(index: indexPath.row), price: viewModel.getCellPriceData(index: indexPath.row))
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
            detailsVC.viewModel = viewModel.navigateToDetails(index: indexPath.row)
            navigationController?.pushViewController(detailsVC, animated: true)
            break
        default:
            self.viewModel.getProductsForSecData(brandId: photoCell[indexPath.row].id)
        //    self.productCollection.reloadData()

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
