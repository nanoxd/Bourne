import Foundation
import XCTest
@testable import Bourne

class NumberTests: XCTestCase {
    func testIntExtensionDecoding() throws {
        let int = try Int.decode(JSON(1))
        let otherInt = JSON(1).int
        let stringInt = JSON("1").int

        XCTAssertEqual(int, 1)
        XCTAssertEqual(otherInt, 1)
        XCTAssertEqual(stringInt, 1)
        
        XCTAssertNil(JSON().int)
        XCTAssertNil(JSON([1]).int)
    }

    func testIntExtensionThrowsError() {
        let json = JSON()
        XCTAssertThrowsError(try Int.decode(json))
    }

    func testIntEquality() {
        let lhs = JSON(1)
        let rhs = JSON(1)

        XCTAssertEqual(lhs, rhs)

        let one = JSON(1)
        let two = JSON(2)
        XCTAssertNotEqual(one, two)

        let stringOne = JSON("1")
        XCTAssertNotEqual(stringOne, one)
    }

    static var allTests = [
        ("testIntExtensionDecoding", testIntExtensionDecoding),
        ("testIntExtensionThrowsError", testIntExtensionThrowsError),
        ("testIntEquality", testIntEquality),
    ]
}
