//
//  LoginVCTests.swift
//  FinalShoppingUnitTests
//
//  Created by Davit Natenadze on 26.05.23.
//

import XCTest
@testable import FinalShopping

final class LoginVCTests: XCTestCase {
    
    var sut: LoginVC!
    var navigation: UINavigationController!
    


    override func setUpWithError() throws {
        sut = LoginVC()
        navigation = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()

    }

    override func tearDownWithError() throws {
        sut.emailTextField.text = nil
        sut.passwordTextField.text = nil
        sut = nil
        navigation = nil
    }

    func testLoginVC_WhenCreated_HasRequiredTextFieldsBlank() {

        XCTAssertEqual(sut.emailTextField.text, "")
        XCTAssertEqual(sut.passwordTextField.text, "")
    }
    
    // not really needed
    func testWhenCreated_Has2ButtonsWithActions() throws {

        // Act
        let loginButton: UIButton = sut.loginButton

        let firstPageActions = loginButton.actions(forTarget: sut, forControlEvent: .touchUpInside) ?? []

        // Assert
        XCTAssertEqual(firstPageActions.count, 1)
    }
    
    func testWhenLoginButtonTapped_PresentsShoppingVC() {
        
        // Arrange
        sut.emailTextField.text = "correctEmail@gmail.com"
        sut.passwordTextField.text = "correctPassword"
        
        let predicate = NSPredicate { input, _ in
            return (input as? UINavigationController)?.topViewController is ShoppingVC
        }

        expectation(for: predicate, evaluatedWith: navigation)

        // act
        sut.loginButton.sendActions(for: .touchUpInside)

        waitForExpectations(timeout: 2)
        
    }

}
