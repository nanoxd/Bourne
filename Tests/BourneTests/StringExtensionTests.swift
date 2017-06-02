import Foundation
import XCTest
@testable import Bourne

class StringExtensionTests: XCTestCase {
    func testStringThrow() throws {
        let array = JSON([1, 2, 3])
        XCTAssertThrowsError(try String.decode(array))
    }

    func testNilString() {
        let optional: String? = nil
        XCTAssertEqual(JSON(optional).string, optional)
    }

    func testStringDecoding() throws {
        let string = "Hey there"
        XCTAssertEqual(JSON(string).string, string)

        let nestedString = ["hey": "there"]
        let json = JSON(nestedString)
        XCTAssertEqual(json["hey"]?.string, nestedString["hey"])

        XCTAssertEqual(try String.decode(json["hey"]), nestedString["hey"])
    }

    func testStringDecodingNumbers() {
        let number = 1
        let decimal = 1.23
        let anotherDecimal: NSDecimalNumber = NSDecimalNumber.one

        XCTAssertEqual(JSON(number).string, String(describing: number))
        XCTAssertEqual(JSON(decimal).string, String(describing: decimal))
        XCTAssertEqual(JSON(anotherDecimal).string, String(describing: anotherDecimal))
    }

    func testURLDecoding() {
        let url = "https://google.com"
        let json = JSON(url)

        XCTAssertNotNil(json.url)
        XCTAssertEqual(json.url?.absoluteString, url)
    }

    static var allTests = [
        ("testStringThrow", testStringThrow),
        ("testStringDecoding", testStringDecoding),
        ("testStringDecodingNumbers", testStringDecodingNumbers),
        ("testNilString", testNilString),
        ("testURLDecoding", testURLDecoding),
    ]
}
