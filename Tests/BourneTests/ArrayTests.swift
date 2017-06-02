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

    static var allTests = [
        ("testArrayDecoding", testArrayDecoding),
        ("testInvalidArrayDecoding", testInvalidArrayDecoding),
    ]
}
