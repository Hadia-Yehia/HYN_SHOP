//
//  ProductInfoViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import Foundation
class ProductInfoViewModel{
    var isLoading : Observable<Bool> = Observable(false)
    var productId : Int
    var product  : ProductInfo = ProductInfo(name: "no data", price: "no data", description: "no data", rate: 0.0 , imgs: Array(), size: "no data")
    init(productId: Int) {
        self.productId = productId
    }
    func getProductInfo(){
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        NetworkService.getInstance().fetchingProductDetails(product_id: productId, completionHandler: {[weak self]
            result in
            self?.isLoading.value = false
            switch result{
            case .success(let data):
                self?.getData(result: data.product)
                break
            case .failure(let error):
                print("error\(error.localizedDescription)")
                break
            }
            
        })
    }
    func getData(result : Product?){
        product.name = result?.title ?? "no data"
        product.description = result?.bodyHtml ?? "no data"
        product.price = result?.variants?.first?.price ?? "no data"
        for i in 0..<(result?.images?.count ?? 0){
            product.imgs.append(result?.images?[i].src ?? "photo1")
        }
    }
    func getProductName()->String{
        return product.name
    }
    func getProductPrice()->String{
        return "EGP\(product.price)"
    }
    func getProductDescription()-> String{
        return product.description
    }
}
