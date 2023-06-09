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
    var size : Observable<Array<String>> = Observable([""])
    var color : Observable<Array<String>> = Observable([""])
    let reviewArray = [ReviewItem(name: "Hadia Yehia", content: "I had a wonderful experience and I would highly recommend this business to others.", rating: 3.5),ReviewItem(name: "Nada Elshafy", content: "I bought a bag from here. The quality is remarkable. It's well worth the money for their high-quality products, I highly recommended!", rating: 4.5)]
    var favDataSource : [Fav]?
    var product  : ProductInfo = ProductInfo(name: "", price: "", description: "", rate: 0.0 , imgs: Array(), size: "",inventoryQuantity:0)
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
                self?.size.value = data.product?.options?.first?.valuesArr
                self?.color.value = data.product?.options?[1].valuesArr
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
        product.name = result?.title ?? ""
        product.description = result?.bodyHtml ?? ""
        product.price = result?.variants?.first?.price ?? ""
        product.inventoryQuantity = result?.variants?.first?.inventoryQuantity ?? 0
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
    
    func getReviews()->[ReviewItem]{
        return reviewArray
    }
    func deleteItemFromFav(){
        favDataSource = FavCoreData.fetchProductsFromDataBase()
       FavCoreData.deleteProduct(id: productId)
        for i in 0..<(favDataSource?.count ?? 0){
            if favDataSource?[i].id == productId{
                favDataSource?.remove(at: i)
            }
        }
        
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
        let item = Fav(title: product.name, price: product.price , img: product.imgs.first ?? "placeholder", id: productId,inventoryQuantity: product.inventoryQuantity)
        print ("save ? \(item.id) \(item.title)")
        FavCoreData.saveProductToDataBase(item: item)
    }
    
//MARK: Cart
    func insertProductInCoreData(size:String,color:String,completionHandler:@escaping (Bool)->Void)
    {
        let productPrice = Float(product.price) ?? 0
        let inventoryQuantity = product.inventoryQuantity
        let cartItem = CartItem(id: Int64(productId), title: product.name, quantity: 1, image: product.imgs.first ?? "placeholder", price:productPrice,defaultPrice: productPrice,inventoryQuantity: inventoryQuantity)
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
