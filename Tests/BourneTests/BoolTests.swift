import Foundation
import XCTest
@testable import Bourne

class BoolTests: XCTestCase {
    func testBoolDecoding() {
        let trueJson = JSON(true)
        let falseJson = JSON(false)

        XCTAssertEqual(trueJson.bool, true)
        XCTAssertEqual(falseJson.bool, false)
    }

    func testBoolIntDecoding() {
        let intFalseJson = JSON(0)
        let intTrueJson = JSON(1)

        XCTAssertEqual(intTrueJson.bool, true)
        XCTAssertEqual(intFalseJson.bool, false)
    }

    func testBoolStringDecoding() {
        let stringTrue = "true"
        let stringFalse = "false"
        
        let trueJson = JSON(stringTrue)
        let falseJson = JSON(stringFalse)

        XCTAssertEqual(trueJson.bool, true)
        XCTAssertEqual(falseJson.bool, false)
        
        XCTAssertNil(JSON("nothing").bool)
        XCTAssertNil(JSON(nil).bool)
    }

    func testBoolThrow() throws {
        let json = JSON([1])
        XCTAssertThrowsError(try Bool.decode(json))
    }

    func testBoolEquality() {
        let trueJson = JSON(true)
        let falseJson = JSON(false)

        XCTAssertEqual(trueJson, JSON(true))
        XCTAssertNotEqual(trueJson, falseJson)
    }

    func testBoolExtension() {
        let json = JSON(true)
        let bool = try? Bool.decode(json)

        XCTAssertEqual(bool, true)
    }

    static var allTests = [
        ("testBoolDecoding", testBoolDecoding),
        ("testBoolIntDecoding", testBoolIntDecoding),
        ("testBoolStringDecoding", testBoolStringDecoding),
        ("testBoolEquality", testBoolEquality),
        ("testBoolExtension", testBoolExtension),
    ]
}
