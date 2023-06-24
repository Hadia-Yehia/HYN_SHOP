//
//  NetworkServiceTest.swift
//  HYNTests
//
//  Created by Hadia Yehia on 21/06/2023.
//

import XCTest
@testable import HYN

final class NetworkServiceTest: XCTestCase {
   // var addressID:Int = 0

    
    let networkService = NetworkService.getInstance()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    


    func testPostingOrderShouldPass(){
        let expectation = expectation(description: "waiting api")
        let defaults = UserDefaults.standard
        var linesArr = [LineItems]()
        var obj1 = LineItems(title: "adidas", price: "200", quantity: 1)
        linesArr.append(obj1)
        let id = (UserDefaults.standard.object(forKey: "userId") as? Int)!
        var customer = PostCustoer(id: 6971932573988)
        let order = Order(customer:customer, lineItems: linesArr)
        let myOrder  = OrderRequest(order: order)
        NetworkService.postingOrder(order: myOrder){
            (data, response, error) in
                if let error = error {
                
                } else if let httpResponse = response as? HTTPURLResponse {
                   
                    if let data = data {
                        XCTAssertNotNil(data)
                        expectation.fulfill()
                        }
                    
                }
        }
        waitForExpectations(timeout: 7,handler: nil)
    }
    
    
    func testGettingOrderShouldPass(){
        let expectation = expectation(description: "waiting api")
        let defaults = UserDefaults.standard
        let id = (UserDefaults.standard.object(forKey: "userId") as? Int)!
        NetworkService.gettingOrder(customerID: id, completion: {
            result in
                switch result{
                case .success(let data):
                    XCTAssertNotNil(data.orders.count,"no data")
                    expectation.fulfill()
                case .failure(let error):
                    print(error.localizedDescription)
                    XCTFail()
                    expectation.fulfill()
                }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }

    func testGettingOrderShouldFail(){
        let expectation = expectation(description: "waiting api")
        NetworkService.gettingOrder(customerID: 988, completion: {
            result in
            switch result{
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }
    
    func testGetCategoryTypeDataShouldPass(){
        let expectation = expectation(description: "waiting api")
        networkService.getCategoryTypeData(type: "SHOSE", completionHandler: { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data.products?.count,"no data")
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
                expectation.fulfill()
            }
            
        })
    
        waitForExpectations(timeout: 7,handler: nil)
    }

    func testGetCategoryTypeDataShouldFail(){
        let expectation = expectation(description: "waiting api")
        networkService.getCategoryTypeData(type: "shose", completionHandler: {
            result in
            switch result{
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }
    
    
    func testGetBrandDataShouldPass(){
        let expectation = expectation(description: "waiting api")
        networkService.getBrandData(completionHandler: { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data.smart_collections?.count,"no data")
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
                expectation.fulfill()
            }
            
        })
     
       
        waitForExpectations(timeout: 7,handler: nil)
    }

    func testGetBrandDataShouldFail(){
        let expectation = expectation(description: "waiting api")
        networkService.getBrandData(completionHandler: {
                result in
                switch result{
                case .success(_):
                    expectation.fulfill()
                case .failure(let error):
                    print(error.localizedDescription)
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
        })
       
        waitForExpectations(timeout: 7,handler: nil)
    }
    
    func testGetProductsDataShouldPass(){
        let expectation = expectation(description: "waiting api")
        networkService.getProductsData(completionHandler: { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data.products?.count,"no data")
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
                expectation.fulfill()
            }
            
            
        })
       
        waitForExpectations(timeout: 7,handler: nil)
    }

    func testGetProductsDataShouldFail(){
        let expectation = expectation(description: "waiting api")
        networkService.getProductsData(completionHandler: {
            result in
                switch result{
                case .success(_):
                    expectation.fulfill()
                case .failure(let error):
                    print(error.localizedDescription)
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
        })
       
        waitForExpectations(timeout: 7,handler: nil)
    }
    func testGetBrandProductsDataShouldPass(){
        let expectation = expectation(description: "waiting api")
        networkService.getBrandProductsData(brand_id: 448683835677, completionHandler: { result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data.products?.count,"no data")
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
                expectation.fulfill()
            }
            
        })
       
        waitForExpectations(timeout: 7,handler: nil)
    }

    func testGetBrandProductsDataShouldFail(){
        let expectation = expectation(description: "waiting api")
        networkService.getBrandProductsData(brand_id: 2, completionHandler: { result in
            switch result{
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }
    func testGetProductInfoShouldPass(){
        let expectation = expectation(description: "waiting api")
        networkService.fetchingProductDetails(product_id: 8348491710749, completionHandler: {result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data.product?.title,"no data")
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }
    func testGetProductInfoShouldFail(){
        let expectation = expectation(description: "waiting api")
        networkService.fetchingProductDetails(product_id: 8, completionHandler: {result in
            switch result{
            case .success(_):
//                XCTAssertNotNil(data.product?.title,"no data")
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }
    func testPostNewCustomerShouldPass(){
        let expectation = expectation(description: "waiting api")
        networkService .postingNewCustomer(customer: CustomerRequest(customer: Customer(first_name: "hadiaa", last_name: "test", email: "hadiaaa@gmail.com", verified_email: true, password: "123456", password_confirmation: "123456", send_email_welcome: true)), completionHandler:{result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data.customer.id)
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }
    func testPostNewCustomerShouldFail(){
        let expectation = expectation(description: "waiting api")
        networkService .postingNewCustomer(customer: CustomerRequest(customer: Customer(first_name: "hadia", last_name: "test", email: "hadia.yehia@gmail.com", verified_email: true, password: "12345", password_confirmation: "12345", send_email_welcome: true)), completionHandler:{result in
            switch result{
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }
    func testPostNewDraftOrderShouldPass(){
        let expectation = expectation(description: "waiting api")
        var draftOrder = DraftOrder()
        var lineItems = [LineItems(title: "test", price: "20", quantity: 1)]
        draftOrder.lineItems = lineItems
        networkService.postingNewDraftOrder(draftOrder: draftOrder, completionHandler: {result in
            switch result{
            case .success(let data):
            XCTAssertEqual(data.draftOrder?.lineItems?.first?.quantity, 1,"data doesn't match")
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }
    func testPostNewDraftOrderShouldFail(){
        let expectation = expectation(description: "waiting api")
        var draftOrder = DraftOrder()
        var lineItems = [LineItems(title: "test", price: "20", quantity: 0)]
        draftOrder.lineItems = lineItems
        networkService.postingNewDraftOrder(draftOrder: draftOrder, completionHandler: {result in
            switch result{
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 7,handler: nil)
    }
    

    func testGetAddresses()
    {
        let myExpectation = expectation(description: "waiting for the API")
        let netwoekService = NetworkService.getInstance()
        netwoekService.getCustomerAddresses{
            result in
    
            switch result {
               case .success(let response):
                
                XCTAssertGreaterThan(response.addresses.count, 0, "Array is not Empty")
         
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
            
                break
           
               }
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testGetCurrencyExchange()
    {
        let myExpectation = expectation(description: "waiting for the API")
        let netwoekService = NetworkService.getInstance()
        netwoekService.getCurrencyExchange
        {
            result in
            switch result {
               case .success(let response):
              
                XCTAssertGreaterThan(response.result.count, 0, "Array is not Empty")
         
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
            
                break
           
               }
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
            
        }
    
    func testGettingDraftOrder()
    {
        let myExpectation = expectation(description: "waiting for the API")
        let netwoekService = NetworkService.getInstance()
        netwoekService.getCustomerDraftOrder(draftOrderId: 1116582183204)
        {
            result in
            switch result {
               case .success(let response):
               // self.addressID = response.customer_address.id ?? 0
                XCTAssertEqual(response.draftOrder?.lineItems?.count,1, "number of line items matched")
                XCTAssertEqual(response.draftOrder?.id,1116582183204, "Draft order id  matched")
             
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
                break
               }
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 20, handler: nil)
        
    }
    func testPostingAddress()
    {
        let myExpectation = expectation(description: "waiting for the API")
        let netwoekService = NetworkService.getInstance()
      let address =  Address(address1: "Sidi-Gaber", first_name: "Yousra", last_name: "Mamdouh", name: "Yousra Mamdouh", city: "Alex", country: "Egypt", phone: "01118723645", zip: "12345")
        netwoekService.createNewAddress(address: address)
        {
            result in
            switch result {
               case .success(let response):
               // self.addressID = response.customer_address.id ?? 0
                XCTAssertEqual(response.customer_address.name,"Yousra Mamdouh", "Name matched")
                XCTAssertEqual(response.customer_address.city,"Alex", "City matched")
                XCTAssertEqual(response.customer_address.phone,"01118723645", "Phone matched")
         
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
            
                break
           
               }
            myExpectation.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    func testDeletingAddress()
    {
        let myExpectation = expectation(description: "waiting for the API")
        let netwoekService = NetworkService.getInstance()
        let address =  Address(address1: "Sidi-Besher", first_name: "Hadia", last_name: "Yehia", name: "Hadia Yehia", city: "Alex", country: "Egypt", phone: "01113333645", zip: "12345" )
        netwoekService.createNewAddress(address: address)
        {
            result in
            switch result {
               case .success(let response):

                netwoekService.deleteAddressFromServer(addressId: response.customer_address.id ?? 0)
                {
                    result in
                    switch result {
                       case .success(let response):

                        XCTAssertEqual(response,EmptyResponse(), "Name matched")


                    case .failure(let error):
                        print(error.localizedDescription)
                        XCTFail()

                        break

                       }
                    myExpectation.fulfill()
                }

            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()

                break

               }
            myExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)

    }
    
    func testUpdateAddress()
    {
        let myExpectation = expectation(description: "waiting for the API")
        let netwoekService = NetworkService.getInstance()
        let address =  Address(address1: "Sidi-Besher", first_name: "Nada", last_name: "Youssef", name: "Nada Youssef", city: "Alex", country: "Egypt", phone: "01119853645", zip: "12345" )
        let updatedAddress =  Address(address1: "Sidi-Besher", first_name: "Nada", last_name: "Youssef", name: "Nada Youssef", city: "Shicago", country: "America", phone: "01237463524", zip: "12345" )
        netwoekService.createNewAddress(address: address)
        {
            result in
            switch result {
               case .success(let response):

                netwoekService.updateCustomerAddress(addressId: response.customer_address.id ?? 0, address: updatedAddress)
                {
                    result in
                    switch result {
                       case .success(let response):

                        XCTAssertEqual(response.customer_address.name,"Nada Youssef", "Name matched")
                        XCTAssertEqual(response.customer_address.city,"Shicago", "City matched")
                        XCTAssertEqual(response.customer_address.phone,"01237463524", "Phone matched")


                    case .failure(let error):
                        print(error.localizedDescription)
                        XCTFail()

                        break

                       }
                    myExpectation.fulfill()
                }

            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()

                break

               }
            myExpectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)

    }
//    func testDeletingAddress()
//    {
//        let myExpectation = expectation(description: "waiting for the API")
//        let netwoekService = NetworkService.getInstance()
//        print("lllllllllllll:\(addressID)")
//        netwoekService.deleteAddressFromServer(addressId: addressID)
//        {
//            result in
//                               switch result {
//                                  case .success(let response):
//
//                                   XCTAssertEqual(response,EmptyResponse(), "Address deleted")
//
//
//                               case .failure(let error):
//                                   print(error.localizedDescription)
//                                   XCTFail()
//
//                                   break
//
//                                  }
//                               myExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 20, handler: nil)
//
//    }
        
    }



