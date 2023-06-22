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

}
