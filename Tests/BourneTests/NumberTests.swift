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

    func testDoubleDecoding() {
        let double = 1.211
        let stringDouble = "1.211"

        XCTAssertEqual(JSON(double).double, double)
        XCTAssertEqual(JSON(stringDouble).double, double)
        XCTAssertEqual(JSON(1).double, 1.0)
    }

    func testInvalidDoubleDecoding() {
        XCTAssertNil(JSON(nil).double)
        XCTAssertNil(JSON([]).double)
    }

    func testDoubleEquality() {
        let lhs = JSON(1.0)
        let rhs = JSON(1.0)

        XCTAssertEqual(lhs, rhs)

        let morePrecision = JSON(1.12121212)
        let andAgain = JSON(1.1212121)

        XCTAssertNotEqual(morePrecision, andAgain)
    }

    func testDoubleExtensionThrows() throws {
        XCTAssertThrowsError(try Double.decode(JSON([])))
    }

    func testDoubleExtension() throws {
        let json = JSON(1.21)
        let double = try Double.decode(json)

        XCTAssertEqual(double, 1.21)
    }

    func testUIntDecoding() {
        let uInt: UInt = 121
        let uIntJson = JSON(uInt)

        XCTAssertEqual(uIntJson.uInt, uInt)
        
        let negativeInt = -124
        let negativeJson = JSON(negativeInt)
        XCTAssertNil(negativeJson.uInt)
        
        let stringUInt = "121"
        XCTAssertEqual(JSON(stringUInt).uInt, uInt)
        
        XCTAssertNil(JSON().uInt)
    }

    static var allTests = [
        ("testIntExtensionDecoding", testIntExtensionDecoding),
        ("testIntExtensionThrowsError", testIntExtensionThrowsError),
        ("testIntEquality", testIntEquality),
        ("testDoubleDecoding", testDoubleDecoding),
        ("testDoubleEquality", testDoubleEquality),
        ("testDoubleExtension", testDoubleExtension),
        ("testDoubleExtensionThrows", testDoubleExtensionThrows),
        ("testInvalidDoubleDecoding", testInvalidDoubleDecoding),
    ]
}
