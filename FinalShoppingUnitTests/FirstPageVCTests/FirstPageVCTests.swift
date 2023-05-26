//
//  FinalShoppingUnitTests.swift
//  FinalShoppingUnitTests
//
//  Created by Davit Natenadze on 25.05.23.
//

import XCTest
@testable import FinalShopping


final class FirstPageVCTests: XCTestCase {

    var sut: FirstPageVC!
    var navigation: UINavigationController!


    override func setUpWithError() throws {
        sut = FirstPageVC()
        navigation = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()

    }

    override func tearDownWithError() throws {
        sut = nil
        navigation = nil

    }

    // MARK: -

    func testFirstPAgeVC_WhenCreated_Has2ButtonsWithActions() throws {
        
        // Act
        let loginButton: UIButton = sut.loginButton
        let registerButton = sut.registerButton

        let firstPageActions = loginButton.actions(forTarget: sut, forControlEvent: .touchUpInside) ?? []
        let registerButtonActions = registerButton.actions(forTarget: sut, forControlEvent: .touchUpInside) ?? []

        // Create a new array by appending registerButtonActions to firstPageActions
        let combinedActions = firstPageActions + registerButtonActions

        // Assert
        XCTAssertEqual(combinedActions.count, 2)
    }
    
    // MARK: - First way
    func testWhenLoginButtonTapped_PresentsLoginVC() {
        
        let predicate = NSPredicate { input, _ in
            return (input as? UINavigationController)?.topViewController is LoginVC
        }
        
        expectation(for: predicate, evaluatedWith: navigation)
        
        // act
        sut.loginButton.sendActions(for: .touchUpInside)
        
        waitForExpectations(timeout: 2)
        
    }
    
    // MARK: - Second way to test same action
    func testWhenRegisterButtonTapped_PresentsRegisterVC() {
        
        // act
        sut.registerButton.sendActions(for: .touchUpInside)
        
        RunLoop.current.run(until: Date())
        
        guard let _ = navigation.topViewController as? RegisterVC else {
            XCTFail()
            return
        }
    }



}





