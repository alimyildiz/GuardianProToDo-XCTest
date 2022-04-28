//
//  GuardianProToDoTests.swift
//  GuardianProToDoTests
//
//  Created by Alim Yıldız on 4/26/22.
//

import XCTest
@testable import GuardianProToDo

class GuardianProToDoTests: XCTestCase {

    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSupportedCodes() {
        
        expectation = self.expectation(description: "SupportedCodesList")
        
        ServiceManager.sharedService.getSupportedCodes { response in
            
            self.expectation!.fulfill() // if this happens, the test must fail

            self.waitForExpectations(timeout: 3)

            XCTAssertNotNil(response, "Data is nil")

            do {
                XCTAssertNotNil((response?.supportedCodesList.count)! > 0, "SupportedCodes is not nil")
                XCTAssertTrue(response?.supportedCodesList != nil)
    
            } catch let error {
                print(error)
            }
        } failure: { error in
            self.expectation!.fulfill()
            XCTFail((error?.localizedDescription)!)
        }
    }
    
    func testCurrencyEvents() {
        
        let currency = "USD"

        ServiceManager.sharedService.getEvents(currency: currency) { response in

            self.expectation = self.expectation(description: "currencyEvents")

            DispatchQueue.main.async {
                XCTFail("bar")

                self.expectation!.fulfill()
            }
            
            self.waitForExpectations(timeout: 3)

            XCTAssertNotNil(response, "Data is nil")

            do {
                XCTAssertNotNil((response?.conversionRatesList.count)! > 0, "SupportedCodes is not nil")
                XCTAssertTrue(response?.conversionRatesList != nil)
    
            } catch let error {
                print(error)
            }
        } failure: { error in
            self.expectation!.fulfill()
            XCTFail((error?.localizedDescription)!)
        }
    }
}
