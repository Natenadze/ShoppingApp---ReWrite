//
//  FinalShoppingUITests.swift
//  FinalShoppingUITests
//
//  Created by Davit Natenadze on 27.05.23.
//

import XCTest

final class LoginVCUITests: XCTestCase {
    
    private var app :XCUIApplication!
    
    // MARK: - Properties

    private var emailTF: XCUIElement!
    private var passwordTF: XCUIElement!
    private var firstPageLoginBtn: XCUIElement!
    private var loginVCLoginBtn: XCUIElement!

    override func setUpWithError() throws {
    
        app = XCUIApplication()
        app.launch()
        
        firstPageLoginBtn = app.buttons["firstPageLoginBtn"]  // use accessibilityIdentifier instead of titleName
        emailTF = app.textFields["Email"]
        passwordTF = app.secureTextFields["Password"]
        loginVCLoginBtn = app.buttons["Login"]  // use TitleName here
        
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        app = nil
        emailTF = nil
        passwordTF = nil
        firstPageLoginBtn = nil
        loginVCLoginBtn = nil
    }

    func testLoginHasAllElementsEnabled() throws {

        let firstPageRegisterBtn = app.buttons["Register"]

        
        XCTAssertTrue(firstPageLoginBtn.isEnabled)  // check its Available and move to next page
        XCTAssertTrue(firstPageRegisterBtn.isEnabled)
        
        firstPageLoginBtn.tap()  // Go to LoginVC
        
        XCTAssertTrue(emailTF.isEnabled)
        XCTAssertTrue(passwordTF.isEnabled)
        XCTAssertTrue(loginVCLoginBtn.isEnabled)
                
    }
    
    
    func testWhenRightEmailAndPasswordProvided_ProductPageAppears() throws {

        firstPageLoginBtn.tap()  // Go to LoginVC
        
        emailTF.tap()
        emailTF.typeText("test@gmail.com")
        
        passwordTF.tap()
        passwordTF.typeText("asd123!!")
        
        loginVCLoginBtn.tap()

        XCTAssertTrue(app.otherElements["ShoppingVC"].waitForExistence(timeout: 1), "ShoppingVC was not presented after successful login")
                
    }
    
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
