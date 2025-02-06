//
//  BitTrendUITests.swift
//  BitTrendUITests
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import XCTest

final class BitTrendUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        self.continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["mock_enabled"]
        app.launch()
        
        self.app = app
    }
    
    override func tearDownWithError() throws {
        
        self.app = nil
    }

    @MainActor
    func testShouldPresentListOfTopTenCoins() throws {
        
        let navBar = self.app.navigationBars.element
        XCTAssertTrue(navBar.exists)
        
        let title = navBar.staticTexts.element.label
        
        if Locale.current.language.languageCode == "it" {
            
            XCTAssertEqual(title, "Prime 10 Valute")
            
        } else {
         
            XCTAssertEqual(title, "Top Ten Coins")
        }
        
        let list = self.app.collectionViews["list"]
        XCTAssertTrue(list.waitForExistence(timeout: 3))
        XCTAssertEqual(list.cells.count, 10)
    }
    
    @MainActor
    func testShouldPresentCoinDetailWithChart() throws {
        
        let list = self.app.collectionViews["list"]
        XCTAssertTrue(list.waitForExistence(timeout: 3))
        list.cells.firstMatch.tap()
        
        let coinInfo = self.app.otherElements["coinChart"]
        XCTAssertTrue(coinInfo.waitForExistence(timeout: 3))
    }
}
