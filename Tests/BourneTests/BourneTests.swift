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
    
    static var allTests = [
        ("testEmptyInitializer", testEmptyInitializer),
        ("testJSONInitializer", testJSONInitalizer),
        ("testDataInitializer", testDataInitializer),
        ("testFileManagerInitializer", testFileManagerInitializer),
        ("testBundleClassInitializer", testBundleClassInitializer),
    ]
}
