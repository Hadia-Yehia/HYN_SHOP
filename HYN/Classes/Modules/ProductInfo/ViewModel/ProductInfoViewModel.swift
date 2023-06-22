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
    var newCurrency: String?
    var result : Product?
    var favDataSource : [Fav]?
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
               // self?.result = data.product
                print("hadia debug " + String(self?.result?.images?.count ?? 0))
                self?.getData(result: data.product)
                
                self?.checkCurrency()
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
            product.imgs.append(result?.images?[i].src ?? "placeholder")
            print("debuuug" + product.imgs[i] )
        }

    }
    func getImgsCount()-> Int{

        return product.imgs.count
        
    }
    func getCellImg(index : Int)->String {

        return product.imgs[index]
    }
    func getProductName()->String {
        return product.name
    }
    func getProductPrice()->String {
        return newCurrency ?? ""
    }
    
    func getProductDescription()-> String{
        return product.description
    }
    
    
    func checkCurrency()
    {  isLoading.value = true
        let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        let productPrice = Float(product.price) ?? 0
        CurrencyManager.exchangePrice(to: currencyCode) {
            exchangeRate in
            self.newCurrency = "\(currencyCode)\(productPrice * exchangeRate)"
            self.isLoading.value = false
           
        }
        // "EGP\(productPrice * CurrencyManager.exchangePrice(to: "EGP"))"

    }
    func checkValidity()-> Bool{
        favDataSource = FavCoreData.fetchProductsFromDataBase()
        for i in 0..<(favDataSource?.count ?? 0){
            if favDataSource?[i].id == productId{
               
                return false
            }
            print("\(String(describing: favDataSource?[i].id)) is equal ? \(productId)" )
        }
        return true
        
    }

    
    func saveItemToDatabase(){
        let item = Fav(title: product.name, price: product.price , img: product.imgs.first ?? "placeholder", id: productId)
        print ("save ? \(item.id) \(item.title)")
        FavCoreData.saveProductToDataBase(item: item)
    }
    
//MARK: Cart
    func insertProductInCoreData(completionHandler:@escaping (Bool)->Void)
    {
        let productPrice = Float(product.price) ?? 0
        let cartItem = CartItem(id: Int64(productId), title: product.name, quantity: 1, image: product.imgs.first ?? "placeholder", price:productPrice,defaultPrice: productPrice)
     if   CartCoreData.shared.InsertCartItem(cartItem)
        {
         completionHandler(true)
     }
        else
        {
            completionHandler(false)
        }
    }

}
