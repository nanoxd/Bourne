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

    static var allTests = [
        ("testArrayDecoding", testArrayDecoding),
    ]
}
