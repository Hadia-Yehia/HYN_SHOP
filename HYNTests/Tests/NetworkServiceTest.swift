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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
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



