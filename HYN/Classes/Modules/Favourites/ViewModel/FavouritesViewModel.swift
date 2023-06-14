//
//  FavouritesViewModel.swift
//  HYN
//
//  Created by Hadia Yehia on 07/06/2023.
//

import Foundation

class FavouritesViewModel{
    var dataSource : [Fav]?
    var isLoading : Observable<Bool> = Observable(false)
    var favCell = Fav(title: "no data", price: "no data", img: "placeholder", id: 0)
    func getFav(){
        dataSource = FavCoreData.fetchItems()
    }
    
    func getTableCount()-> Int{
        return dataSource?.count ?? 0
    }
    func getObjectForCell(index:Int)->Fav{
        favCell.img = dataSource?[index].img ?? "placeholder"
        favCell.title = dataSource?[index].title ?? "No Data"
        favCell.id = dataSource?[index].id ?? 0
        favCell.price = dataSource?[index].price ?? "No Data"
        return favCell
    }
    func deleteItem(index : Int){
        FavCoreData.deleteItem(id: dataSource?[index].id ?? 0)
        dataSource?.remove(at: index)
    }
    func navigateToDetailsScreen(index : Int) -> ProductInfoViewModel {
        let productId = dataSource?[index].id ?? 0
        return ProductInfoViewModel(productId: productId)
        
    }
}
