//
//  AutoDocNewsUITests.swift
//  AutoDocNewsUITests
//
//  Created by Алексей Усанов on 02.02.2023.
//

import XCTest

final class AutoDocNewsUITests: XCTestCase {
    
    func testLoadMore() throws {
        let app = XCUIApplication()
        app.launch()
        
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.buttons["Загрузить ещё"].tap()
    }
    
    func testScroll() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().scrollViews.otherElements.containing(.button, identifier:"Загрузить ещё").children(matching: .other).element.children(matching: .image).element(boundBy: 5).swipeUp()
    }
}
