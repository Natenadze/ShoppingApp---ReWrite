//
//  SummaryVMTests.swift
//  FinalShoppingUnitTests
//
//  Created by Davit Natenadze on 28.05.23.
//

import XCTest
@testable import FinalShopping


final class SummaryVMTests: XCTestCase {
    
    var sut: SummaryVM!
    

    override func setUpWithError() throws {
        let mockBasket = MockSummaryVM.shared.basketModel
        sut = SummaryVM(basketModel: mockBasket)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testsubTotal() throws {
        XCTAssertEqual(sut.subTotal, 100, "wrong subTotal")
    }
    
    func testVat() throws {
        XCTAssertEqual(sut.vat, 21, "wrong subTotal")
    }
    
    func testDelivery() throws {
        XCTAssertEqual(sut.delivery, 0, "wrong subTotal")
    }
    
    func testTotal() throws {
        XCTAssertEqual(sut.Total, 121, "wrong subTotal")
    }
    
    



}
