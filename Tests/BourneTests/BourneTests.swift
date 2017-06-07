import Foundation
import XCTest
import Bourne

class BourneTests: XCTestCase {
    func testEmptyInitializer() {
        let json = JSON()

        XCTAssertNil(json.object)
    }

    func testJSONInitalizer() {
        let json = JSON("hey")
        let otherJSON = JSON(json: json)

        XCTAssertEqual(otherJSON, json)
    }
    
    func testDataInitializer() {
        let data = "\"people\"".data(using: String.Encoding.utf8)
        let json = JSON(data: data)

        XCTAssertNotNil(json)
        XCTAssertEqual(json?.string, "people")

        let emptyDataJSON = JSON(data: nil)
        XCTAssertNil(emptyDataJSON)

        let invalidData = "people".data(using: .utf8)
        XCTAssertNil(JSON(data: invalidData))
    }

    func testFileManagerInitializer() {
        XCTAssertNil(JSON(path: ""))

        let testBundle = Bundle(for: BourneTests.self)
        let filePath = testBundle.path(forResource: "some.json", ofType: nil)!

        guard let file = JSON(path: filePath) else {
            XCTFail("Could not find test file")
            return
        }

        XCTAssertEqual(file["person"]?["id"]?.int, 1)
    }

    func testBundleClassInitializer() {
        let json = JSON(bundleClass: BourneTests.self, filename: "some.json")

        XCTAssertNotNil(json)
    }

    func testBundleInitializer() {
        let bundle = Bundle(for: BourneTests.self)
        let invalidFile = JSON(bundle: bundle, filename: "not_here.json")

        XCTAssertNil(invalidFile)

        let validFile = JSON(bundle: bundle, filename: "some.json")
        XCTAssertNotNil(validFile)
        XCTAssertEqual(validFile?["person"]?["id"]?.int, 1)
    }

    func testSubscript() {
        var json = JSON(["key": "value"])
        XCTAssertEqual(json["key"]?.string, "value")

        json["key"] = JSON("newValue")
        XCTAssertEqual(json["key"]?.string, "newValue")

        var emptyJson = JSON()
        emptyJson["key"] = JSON("value")

        XCTAssertEqual(emptyJson["key"]?.string, "value")

        let notADict = JSON(1)
        XCTAssertNil(notADict["key"])
    }

    func testEquality() {
        let json = JSON()
        let otherJson = JSON(1)

        XCTAssertNotEqual(json, otherJson)
    }

    func testKeyPathSupport() {
        let dict: [String: Any] = [
            "an": "item",
            "this": ["key": "path"]
        ]

        let json = JSON(dict)

        XCTAssertEqual(json.value(for: "this.key")?.string, "path")
        XCTAssertNil(json.value(for: "this.not.a.key"))
    }
    
    static var allTests = [
        ("testEmptyInitializer", testEmptyInitializer),
        ("testJSONInitializer", testJSONInitalizer),
        ("testDataInitializer", testDataInitializer),
        ("testFileManagerInitializer", testFileManagerInitializer),
        ("testBundleClassInitializer", testBundleClassInitializer),
        ("testBundleInitializer", testBundleInitializer),
        ("testSubscript", testSubscript),
        ("testEquality", testEquality),
    ]
}
