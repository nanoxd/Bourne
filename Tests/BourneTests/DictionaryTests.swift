import Foundation
import XCTest
@testable import Bourne

class DictionaryTests: XCTestCase {
    let dict = ["a": "dog", "b": "cat"]

    func testDictionaryDecoding() {
        let json = JSON(dict)

        XCTAssertEqual(json.dictionary!, ["a": JSON("dog"), "b": JSON("cat")])

        let anArray = [1, 2, 3]
        let notADict = JSON(anArray)
        XCTAssertNil(notADict.dictionary)
    }

    func testDictionaryValue() {
        let json = JSON(dict)

        XCTAssertEqual(json.dictionaryValue.count, 2)
        XCTAssertEqual(JSON().dictionaryValue.count, 0)
    }
    
    func testEquality() {
        let json = JSON(dict)
        let otherJson = JSON(dict)

        XCTAssertEqual(json, otherJson)
    }

    static var allTests = [
        ("testDictionaryDecoding", testDictionaryDecoding),
        ("testEquality", testEquality),
    ]
}
