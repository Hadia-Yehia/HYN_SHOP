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
    let adsArray = [Advertisement(image: "ad1", coupon: "7t65dehbj874"),Advertisement(image: "ad2", coupon: "rfrkj893nmn4"),Advertisement(image: "ad3", coupon: "498ojf84jw3s"),Advertisement(image: "ad4", coupon: "tj99484r87u1")]

   // var testArray:[SmartCollections]?
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
               // self?.testArray = data.smart_collections
                break
            case .failure(let error):
                break
                
            }
        })

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
    
    func navigateToBrandView(index :Int) ->BrandViewModel
    {
        let brandId = brandArr[index].id
        return BrandViewModel(brandId: brandId)
    }
  
   /* func navigateToBrandView(index :Int) ->Int
     {
       
         return self.testArray?[index].id ?? 0
     }*/
    //MARK: Ads collection
    func getAdsArrayCount()->Int
    {
        adsArray.count
    }
    func getAd(index:Int)-> Advertisement
    {
        adsArray[index]
    }
}

