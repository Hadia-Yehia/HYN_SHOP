//
//  CategoryViewModel.swift
//  HYN
//
//  Created by Nada youssef on 11/06/2023.
//

import Foundation
class CategoryViewModel{
    var isLoading : Observable<Bool> = Observable(false)
    //var isLoadingTwo : Observable<Bool> = Observable(false)
    //var isLoadingThree : Observable<Bool> = Observable(false)

    var productArr : [ProductsStruct] = Array()
    var collectionArr : [CollectionStruct] = Array()
    var filteredArr : [ProductsStruct] = Array()
    //var productForSecArr : [ProductsStruct] = Array()
    //var brandId : Int = 0
    func getProductsForSecData(brandId: Int){
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        NetworkService.getInstance().getBrandProductsData(brand_id: brandId, completionHandler: {
            [weak self]
            result in
            self?.isLoading.value = false
            switch result{
            case .success(let data):
                print("success the count is \(data.products?.count)")
                self?.getData(data: data.products!)
                break
            case .failure(let error):
                break
                
            }
        })
    }
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
    
    func getCategoryForSecData(type: String){
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        NetworkService.getInstance().getCategoryTypeData(type: type, completionHandler: {
            [weak self]
            result in
            self?.isLoading.value = false
            switch result{
            case .success(let data):
                print("success the count is \(data.products?.count)")
                self?.getData(data: data.products!)
                break
            case .failure(let error):
                break
                
            }
        })
    }
    func navigateToDetails(index : Int) -> ProductInfoViewModel{
        return ProductInfoViewModel(productId: filteredArr[index].id)
    }
    
    /*func getCollectionData(){
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
        
   
    }*/
    
    func getTypeData(data : [CustomCollections]){
        collectionArr.removeAll()
        for i in 1..<data.count-1{
            let productsType = CollectionStruct(id: data[i].id!, title: data[i].title!, img: (data[i].image?.src)!)
            
            collectionArr.append(productsType)
        }
    }
    func getProductsTypeCount() -> Int{
        return collectionArr.count-1
    }
    func getProductsCount() -> Int{
        return filteredArr.count
    }
    func getData(data : [Product]){
        productArr = [ProductsStruct]()
        for i in 0..<data.count{
            let products = ProductsStruct(id: data[i].id!, price: (data[i].variants?.first?.price)!, img: (data[i].image?.src!)!,title: data[i].title!,inventoryQuantity: (data[i].variants?.first?.inventoryQuantity)!)
            
            productArr.append(products)
        }
        filteredArr = productArr
    }
    func getCellImgData(index : Int)->String{
        return (filteredArr[index].img)
    }
    func getCellPriceData(index : Int)->String{
        return (filteredArr[index].price)
    }
    func getCellNameData(index : Int)->String{
        return (filteredArr[index].title)
    }
    func getCellIdData(index : Int)->Int{
        return (filteredArr[index].id)
    }
    func getCellInventoryQuantity (index : Int)->Int{
        return (filteredArr[index].inventoryQuantity)
    }
   /* func getCellImgTypeData(index : Int)->String{
        return (collectionArr[index].img)
    }
    func getCellTitleTypeData(index : Int)->String{
        return (collectionArr[index].title)
    }*/
    func search(searchText : String){
        if searchText.isEmpty == false{
            filteredArr = productArr.filter{$0.title.lowercased().contains(searchText.lowercased())}
           
               }
        else if searchText.isEmpty{
           filteredArr = productArr
        }
    }
    
    
}
