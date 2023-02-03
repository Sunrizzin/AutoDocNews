//
//  AutoDocNewsTests.swift
//  AutoDocNewsTests
//
//  Created by Алексей Усанов on 02.02.2023.
//

import XCTest
@testable import AutoDocNews

final class AutoDocNewsTests: XCTestCase {
    func testParse() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "mock", ofType: "json") else {
            fatalError("UnitTestData.json not found")
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to String")
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to Data")
        }
        
        do {
            let _ = try JSONDecoder().decode(Root.self, from: jsonData)
        }
        catch {
            XCTFail("Не удалось распарсить mock JSON имеющейся моделью Root")
        }
    }
    
}
