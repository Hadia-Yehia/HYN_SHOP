//
//  BrandViewModel.swift
//  HYN
//
//  Created by Nada youssef on 12/06/2023.
//

import Foundation
class BrandViewModel{
    var isLoading : Observable<Bool> = Observable(false)
    var productArr : [ProductsStruct] = Array()
    var searchFilteredArr : [ProductsStruct] = Array()
    var brandIdFromHome:Int
    var isFiltering = false
    var filterArr : [ProductsStruct] = Array()
    init(brandId:Int)
    {
        self.brandIdFromHome = brandId
    }
    func getBrandProductsData(){
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        NetworkService.getInstance().getBrandProductsData(brand_id: brandIdFromHome, completionHandler: {
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
    func getBrandsCount() -> Int{
        return searchFilteredArr.count
    }
    func getData(data : [Product]){
        productArr.removeAll()
        for i in 0..<data.count{
            let products = ProductsStruct(id: data[i].id!, price: (data[i].variants?.first?.price)!, img: (data[i].image?.src!)!,title: data[i].title!,inventoryQuantity: (data[i].variants?.first?.inventoryQuantity)!)
            productArr.append(products)
        }
        searchFilteredArr = productArr
    }
    func getCellImgData(index : Int)->String{
        return searchFilteredArr[index].img
    }
    func getCellPriceData(index : Int)->String{
        return searchFilteredArr[index].price
    }
    func getCellNameData(index : Int)->String{
        return searchFilteredArr[index].title
    }
    func getCellIdData(index : Int)->Int{
        return searchFilteredArr[index].id
    }
    func getCellInventoryQuantity (index : Int)->Int{
        return (searchFilteredArr[index].inventoryQuantity)
    }
    func search(searchText : String){
        if searchText.isEmpty == false{
            searchFilteredArr = productArr.filter{$0.title.lowercased().contains(searchText.lowercased())}
           
               }
        else if searchText.isEmpty{
          searchFilteredArr = productArr
        }
    }
    func navigateToDetails(index : Int) -> ProductInfoViewModel{
            return ProductInfoViewModel(productId: searchFilteredArr[index].id)
        }

}

