//
//  CategoryViewModel.swift
//  HYN
//
//  Created by Nada youssef on 11/06/2023.
//

import Foundation
class CategoryViewModel{
    var isLoading : Observable<Bool> = Observable(false)
    var isLoadingTwo : Observable<Bool> = Observable(false)

    var productArr : [ProductsStruct] = Array()
    var collectionArr : [CollectionStruct] = Array()
    func getProductData(){
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        NetworkService.getInstance().getProductsData(completionHandler: {
            [weak self]
            result in
            self?.isLoading.value = false
            switch result{
            case .success(let data):
                print("success\(data.products?.count)")
                self?.getData(data: data.products!)
                break
            case .failure(let error):
                break
                
            }
        })
   
    }
    
    func getCollectionData(){
        if isLoadingTwo.value ?? true{
            return
        }
        isLoadingTwo.value = true
        NetworkService.getInstance().getProductsType(completionHandler: {
            [weak self]
            result in
            self?.isLoadingTwo.value = false
            switch result{
            case .success(let data):
                print("success\(data.customCollections?.count)")
                print("in collection \((data.customCollections?.count))")
                self?.getTypeData(data: data.customCollections!)
                break
            case .failure(let error):
                break
                
            }
        })
        
   
    }
    
    func getTypeData(data : [CustomCollections]){
        for i in 1..<data.count-1{
            let productsType = CollectionStruct(id: data[i].id!, title: data[i].title!, img: (data[i].image?.src)!)
            
            collectionArr.append(productsType)
        }
    }
    func getProductsTypeCount() -> Int{
        return collectionArr.count-1
    }
    func getProductsCount() -> Int{
        return productArr.count
    }
    func getData(data : [Product]){
        for i in 0..<data.count{
            let products = ProductsStruct(id: data[i].id!, price: (data[i].variants?.first?.price)!, img: (data[i].image?.src!)!)
            
            productArr.append(products)
        }
    }
    func getCellImgData(index : Int)->String{
        return (productArr[index].img)
    }
    func getCellPriceData(index : Int)->String{
        return (productArr[index].price)
    }
   /* func getCellImgTypeData(index : Int)->String{
        return (collectionArr[index].img)
    }
    func getCellTitleTypeData(index : Int)->String{
        return (collectionArr[index].title)
    }*/
    
    
}
