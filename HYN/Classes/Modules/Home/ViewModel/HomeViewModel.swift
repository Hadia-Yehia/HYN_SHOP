//
//  HomeViewModel.swift
//  HYN
//
//  Created by Nada youssef on 10/06/2023.
//

import Foundation
class HomeViewModel{
    var isLoading : Observable<Bool> = Observable(false)
    var brandArr : [BrandStruct] = Array()
    func getbrandData(){
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        NetworkService.getInstance().getBrandData(completionHandler: {
            [weak self]
            result in
            self?.isLoading.value = false
            switch result{
            case .success(let data):
                print("success\(data.smart_collections?.count)")
                self?.getData(data: data.smart_collections!)
                break
            case .failure(let error):
                break
                
            }
        })
//        NetworkService.getInstance().fetchingProductDetails(product_id: productId, completionHandler: {[weak self]
//            result in
//            self?.isLoading.value = false
//            switch result{
//            case .success(let data):
//               // self?.result = data.product
//                print("hadia debug " + String(self?.result?.images?.count ?? 0))
//                self?.getData(result: data.product)
//
//
//                break
//            case .failure(let error):
//                print("error\(error.localizedDescription)")
//                break
//            }
//
//        })
    }
    func getBrandsCount() -> Int{
        return brandArr.count
    }
    func getData(data : [SmartCollections]){
        for i in 0..<data.count{
            let brand = BrandStruct(img: (data[i].image?.src)!, id: data[i].id!)
            brandArr.append(brand)
        }
    }
    func getCellData(index : Int)->String{
        return brandArr[index].img
    }
}

