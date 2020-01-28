//
//  NewsUITests.swift
//  NewsUITests
//
//  Created by Furqan Khan on 12/19/19.
//  Copyright © 2019 Kalsa. All rights reserved.
//

import XCTest

class NewsUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    func testOpeningNewsItemInBrowser() {
        // UI tests must launch the application that they test.
        app.launch()
        
        // Assert existence of news list table
        XCTAssertTrue(app.isDisplayingNewsList)
        
        let newsListTable = app.tables.firstMatch
        let cell = newsListTable.cells.firstMatch
        
        // Wait for network call to finish
        _ = cell.waitForExistence(timeout: 3)
        
        // Tap a cell to open the browser
        cell.tap()
        
        // Wait for the browser to open
        sleep(1)
        
        // Switch back to the News app
        app.activate()
        
        // Check existence of news list table
        XCTAssertTrue(app.isDisplayingNewsList)
    }
}

extension XCUIApplication {
    var newsListTableView: XCUIElement {
        return tables["accessibility_news_list_table_view"]
    }
    
    var isDisplayingNewsList: Bool {
        return newsListTableView.exists
    }
}
