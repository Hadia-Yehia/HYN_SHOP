//
//  MockAPICallerTests.swift
//  SportsHubTests
//
//  Created by Yousra Mamdouh Ali on 02/06/2023.
//

import XCTest
@testable import HYN
final class MockNetworkCallerTests: XCTestCase {

    override func setUp() {
     
    }

    override func tearDown() {
    
    }

    // MARK: testing currency exchange 
func testgetCurrencyExchanges()
    {
        let networkManager = MockNetworkCaller(shouldReturnError: false)
        networkManager.getCurrencyExchange(url: ""){
            (items,error)
            in
            
            guard let items = items else
            {
                XCTFail()
                return
            }
            XCTAssertEqual(items.rates.USD,1, "There is a response")
      
            
        }
    
    }
    // MARK: testing product response
func testgetProductResponse()
    {
        let networkManager = MockNetworkCaller(shouldReturnError: false)
        networkManager.fetchingProductDetails(product_id: 0, completionHandler: {
            result in
            switch result{
            case .failure(let error):
                print(error)
                XCTFail()
                break
            case .success(let data):
                XCTAssertGreaterThan(data.product?.images?.count ?? 0, 0)
                break
            }
        })
    }
    // MARK: testing Brand Data
    func testGetBrandDataResponse()
        {
            let networkManager = MockNetworkCaller(shouldReturnError: false)
            networkManager.getBrandData(completionHandler: {
                result in
                switch result{
                case .failure(let error):
                    print(error)
                    XCTFail()
                    break
                case .success(let data):
                    XCTAssertGreaterThan(data.smart_collections?.count ?? 0, 0)
                    break
                }
            })
       
        }
    
    // MARK: testing Brand Data
    func testGetProductsDataResponse()
        {
            let networkManager = MockNetworkCaller(shouldReturnError: false)
            networkManager.getProductsData(completionHandler: {
                result in
                switch result{
                case .failure(let error):
                    print(error)
                    XCTFail()
                    break
                case .success(let data):
                    XCTAssertGreaterThan(data.products?.count ?? 0, 0)
                    break
                }
            })
           
       
        }
    // MARK: testing post order
    func testpostingOrder()
        {
            let networkManager = MockNetworkCaller(shouldReturnError: false)
            networkManager.postingOrder(completionHandler: {
                result in
                switch result{
                case .failure(let error):
                    print(error)
                    XCTFail()
                    break
                case .success(let data):
                    XCTAssertGreaterThan(data.order.line_items.count ?? 0, 0)
                    break
                }
            })
           
       
        }
    // MARK: testing get order
    func testgettingOrder()
        {
            let networkManager = MockNetworkCaller(shouldReturnError: false)
            networkManager.gettingOrder(completionHandler: {
                result in
                switch result{
                case .failure(let error):
                    print(error)
                    XCTFail()
                    break
                case .success(let data):
                    XCTAssertGreaterThan(data.orders.count ?? 0, 0)
                    break
                }
            })
      
        }
    
    
    
    
    
    
    
    
    // MARK: testing Brand Product
    func testGetBrandProductDataResponse()
        {
            let networkManager = MockNetworkCaller(shouldReturnError: false)
            networkManager.getBrandProductsData(brand_id: 448683835677, completionHandler: {
                result in
                switch result{
                case .failure(let error):
                    print(error)
                    XCTFail()
                    break
                case .success(let data):
                    XCTAssertGreaterThan(data.products?.count ?? 0, 0)
                    break
                }
            })
        }
    
    // MARK: testing Brand Product
    func testGetCategoryTypeDataResponse()
        {
            let networkManager = MockNetworkCaller(shouldReturnError: false)
            networkManager.getCategoryTypeData(type: "SHOSE", completionHandler: {
                result in
                switch result{
                case .failure(let error):
                    print(error)
                    XCTFail()
                    break
                case .success(let data):
                    XCTAssertGreaterThan(data.products?.count ?? 0, 0)
                    break
                }
            })
         
        }
    // MARK: testing customer response
func testCustomerResponse()
    {
        let networkManager = MockNetworkCaller(shouldReturnError: false)
        networkManager.postingNewCustomer(completionHandler: {
            result in
            switch result{
            case .failure(let error):
                print(error)
                XCTFail()
                break
            case .success(let data):
                XCTAssertEqual(data.customer.id, 1073339469)
                break
            }
        })
    }
    // MARK: testing customer request
func testCustomerRequest()
    {
        let networkManager = MockNetworkCaller(shouldReturnError: false)
        networkManager.requestNewCustomer(completionHandler: {
            result in
            switch result{
            case .failure(let error):
                print(error)
                XCTFail()
                break
            case .success(let data):
                XCTAssertEqual(data.customer.email, "steve.lastnameson@example.com")
                break
            }
        })
    }
    
    //MARK: testing creating new address
    func testAddressRequest()
        {
            let networkManager = MockNetworkCaller(shouldReturnError: false)
            networkManager.createNewAddress(completionHandler: {
                result in
                switch result{
                case .failure(let error):
                    print(error)
                    XCTFail()
                    break
                case .success(let data):
                    XCTAssertEqual(data.customer_address.address1, "1 Rue des Carrieres")
                    break
                }
            })
        }
    
    //MARK: testing getting customer addresses
    
    func testAddressResponse()
        {
            let networkManager = MockNetworkCaller(shouldReturnError: false)
            networkManager.getCustomerAddresses(completionHandler: {
                result in
                switch result{
                case .failure(let error):
                    print(error)
                    XCTFail()
                    break
                case .success(let data):
                    XCTAssertEqual(data.addresses.first?.company, "Fancy Co.")
                    XCTAssertEqual(data.addresses.first?.country, "Canada")
                    XCTAssertEqual(data.addresses.first?.first_name, "Samuel")
                    XCTAssertEqual(data.addresses.count, 1)
                    break
                }
            })
        }
    // MARK: testing draft order request
func testDraftOrderRequest()
    {
        let networkManager = MockNetworkCaller(shouldReturnError: false)
        networkManager.requestNewDraftOrder(completionHandler: {
            result in
            switch result{
            case .failure(let error):
                print(error)
                XCTFail()
                break
            case .success(let data):
                XCTAssertGreaterThan(data.draft_order.lineItems?.count ?? 0, 0)
                break
            }
        })
    }
    // MARK: testing draft order response
func testDraftOrderResponse()
    {
        let networkManager = MockNetworkCaller(shouldReturnError: false)
        networkManager.postingNewDraftOrder(completionHandler:{
            result in
            switch result{
            case .failure(let error):
                print(error)
                XCTFail()
                break
            case .success(let data):
                XCTAssertNotNil(data.draftOrder?.id)
                break
            }
        })
    }




}
