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
        
        let expectation: XCTestExpectation = self.expectation(description: "SupportedCodesList")
        
        ServiceManager.sharedService.getSupportedCodes { response in
            
            expectation.fulfill() // if this happens, the test must fail

            self.waitForExpectations(timeout: 3)

            XCTAssertNotNil(response, "Data is nil")

            do {
                XCTAssertNotNil((response?.supportedCodesList.count)! > 0, "SupportedCodes is not nil")
                XCTAssertTrue(response?.supportedCodesList != nil)
    
            } catch let error {
                print(error)
            }
        } failure: { error in
            expectation.fulfill()
            XCTFail((error?.localizedDescription)!)
        }
    }
}
