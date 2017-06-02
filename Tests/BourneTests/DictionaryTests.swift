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

    func testDictionaryExtensionThrows() throws {
        XCTAssertThrowsError(try [String: String].decode(JSON()))
        XCTAssertThrowsError(try [String: String].decode(JSON(1)))
    }

    func testDictionaryExtension() throws {
        let dictJSON = JSON(dict)
        let parsedDict = try [String: String].decode(dictJSON)

        XCTAssertEqual(parsedDict["a"], "dog")
        XCTAssertEqual(parsedDict.count, 2)
    }

    func testNSDictionaryExtensionThrows() throws {
        XCTAssertThrowsError(try NSDictionary.decode(JSON()))
        XCTAssertThrowsError(try NSDictionary.decode(JSON(1)))
    }

    func testNSDictionaryExtension() throws {
        let dictJSON = JSON(dict)
        let parsedDict = try NSDictionary.decode(dictJSON)

        XCTAssertEqual(parsedDict.object(forKey: "a") as? String, "dog")
        XCTAssertEqual(parsedDict.count, 2)
    }

    static var allTests = [
        ("testDictionaryDecoding", testDictionaryDecoding),
        ("testDictionaryValue", testDictionaryValue),
        ("testDictionaryExtensionThrows", testDictionaryExtensionThrows),
        ("testDictionaryExtension", testDictionaryExtension),
        ("testEquality", testEquality),
        ("testNSDictionaryExtensionThrows", testNSDictionaryExtensionThrows),
        ("testNSDictionaryExtension", testNSDictionaryExtension),
    ]
}
