//
//  ProductInfoViewController+CollectionVIew.swift
//  HYN
//
//  Created by Hadia Yehia on 09/06/2023.
//

import Foundation
import UIKit

extension ProductInfoViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func setupCollectionView(){
        self.imgsCollectionView.delegate = self
        self.imgsCollectionView.dataSource = self
        self.imgsCollectionView.register(UINib(nibName: "ProductInfoCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "ProductInfoCollectionViewCell")
        self.imgsCollectionView.isPagingEnabled = true
        imgsCollectionView.showsHorizontalScrollIndicator = false
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print (viewModel?.getImgsCount())
        return viewModel?.getImgsCount() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imgsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductInfoCollectionViewCell", for: indexPath) as! ProductInfoCollectionViewCell
        cell.configCell(imgSRC: viewModel?.getCellImg(index: indexPath.row) ?? "placeholder")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.bounds.width, height: collectionView.bounds.height)
    }
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.imgsPageControl.currentPage = indexPath.section
    }

    
    
}
