//
//  RegisterVCTests.swift
//  FinalShoppingUnitTests
//
//  Created by Davit Natenadze on 26.05.23.
//

import XCTest
@testable import FinalShopping

final class RegisterVCTests: XCTestCase {
    
    var sut: RegisterVC!
    var navigation: UINavigationController!
    


    override func setUpWithError() throws {
        sut = RegisterVC()
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
        let registerButton: UIButton = sut.registerButton

        let registerVCActions = registerButton.actions(forTarget: sut, forControlEvent: .touchUpInside) ?? []

        // Assert
        XCTAssertEqual(registerVCActions.count, 1)
    }
    
    func testWhenRegisterButtonTapped_PresentsLoginVC() {
        
        // Arrange
        sut.emailTextField.text = "someEmail@gmail2.com"
        sut.passwordTextField.text = "correctPassword"
        
        let predicate = NSPredicate { input, _ in
            return (input as? UINavigationController)?.topViewController is LoginVC
        }

        expectation(for: predicate, evaluatedWith: navigation)

        // act
        sut.registerButton.sendActions(for: .touchUpInside)

        // if fail: change email and password text (its already registered maybe )
        waitForExpectations(timeout: 3)
        
    }

}
