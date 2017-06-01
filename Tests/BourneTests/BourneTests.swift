import Foundation
import XCTest
import Bourne

class BourneTests: XCTestCase {
    func testDataInitializer() {
        let data = "\"people\"".data(using: String.Encoding.utf8)
        let json = JSON(data: data)

        XCTAssertNotNil(json)
        XCTAssertEqual(json?.string, "people")

        let emptyDataJSON = JSON(data: nil)
        XCTAssertNil(emptyDataJSON)
    }
    
    static var allTests = [
        ("testDataInitializer", testDataInitializer),
    ]
}
