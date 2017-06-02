import Foundation
import Foundation
import XCTest
@testable import Bourne

class ArrayTests: XCTestCase {
    func testArrayDecoding() {
        let json = JSON([1])

        XCTAssertEqual(json.array?.first?.int, 1)
        XCTAssertEqual(json.array?.count, 1)
    }

    func testInvalidArrayDecoding() {
        let notAnArray = JSON(nil)

        XCTAssertNil(notAnArray.array)
        XCTAssertEqual(notAnArray.arrayValue, [])
    }

    func testArrayExtensionThrows() throws {
        let notAnArray = JSON(1)

        XCTAssertThrowsError(try [Int].decode(notAnArray))
    }

    func testArrayExtension() throws {
        let array = [1, 2, 3]
        let json = JSON(array)

        let anotherArray = Array(1...10000)
        let anotherJson = JSON(anotherArray)

        let numbers = try! [Int].decode(json)
        XCTAssertEqual(numbers, array)
        
        let moreNumbers = try! [Int].decode(anotherJson)
        XCTAssertEqual(moreNumbers, anotherArray)
    }

    func testArrayEquality() throws {
        let lhs = JSON([1, 2, 3])
        let rhs = JSON([1, 2, 3])

        XCTAssertEqual(lhs, rhs)
        XCTAssertNotEqual(lhs, JSON([1, 2]))
        XCTAssertNotEqual(lhs, JSON(1))
    }

    static var allTests = [
        ("testArrayDecoding", testArrayDecoding),
        ("testInvalidArrayDecoding", testInvalidArrayDecoding),
        ("testArrayExtensionThrows", testArrayExtensionThrows),
        ("testArrayExtension", testArrayExtension),
        ("testArrayEquality", testArrayEquality),
    ]
}
