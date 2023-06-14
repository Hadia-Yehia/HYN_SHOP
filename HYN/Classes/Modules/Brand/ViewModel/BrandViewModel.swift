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
        return productArr.count
    }
    func getData(data : [Product]){
        for i in 0..<data.count{
            let products = ProductsStruct(id: data[i].id!, price: (data[i].variants?.first?.price)!, img: (data[i].image?.src!)!)
            productArr.append(products)
        }
    }
    func getCellImgData(index : Int)->String{
        return productArr[index].img
    }
    func getCellPriceData(index : Int)->String{
        return productArr[index].price
    }
}

