import Foundation
import XCTest
@testable import Bourne

class DictionaryTests: XCTestCase {
    let dict = ["a": "dog", "b": "cat"]

    func testEquality() {
        let json = JSON(dict)
        let otherJson = JSON(dict)

        XCTAssertEqual(json, otherJson)
    }

    static var allTests = [
        ("testEquality", testEquality),
    ]
}
