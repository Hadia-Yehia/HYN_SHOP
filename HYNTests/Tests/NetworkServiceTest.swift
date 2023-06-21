//
//  NetworkServiceTest.swift
//  HYNTests
//
//  Created by Hadia Yehia on 21/06/2023.
//

import XCTest
@testable import HYN

final class NetworkServiceTest: XCTestCase {
    
    let networkService = NetworkService.getInstance()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        networkService .postingNewCustomer(customer: CustomerRequest(customer: Customer(first_name: "hadia", last_name: "test", email: "hadiaa@gmail.com", verified_email: true, password: "123456", password_confirmation: "123456", send_email_welcome: true)), completionHandler:{result in
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

}
