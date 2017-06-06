import Foundation
import XCTest
@testable import Bourne

enum TestError: Error {
    case invalidJSON
}

struct SimpleModel: Decodable {
    let key: String
    let number: Int
    let bool: Bool
    let nestedKey: String
    let defaultItem: String

    static func decode(_ j: JSON?) throws -> SimpleModel {
        guard let j = j else { throw TestError.invalidJSON }
        return SimpleModel(
            key: try j.decode("key"),
            number: try j.decode("number"),
            bool: try j.decode("bool"),
            nestedKey: try j.decode("nestedKey.is"),
            defaultItem: try j.decode("invalidKey", or: "Default")
        )
    }
}

class DecodableTests: XCTestCase {
    let dict: [String: Any] = [
        "key": "value",
        "number": 1024,
        "bool": false,
        "nestedKey": ["is": "here"]
    ]

    var json: JSON!
    var model: SimpleModel?

    override func setUp() {
        json = JSON(dict)

        model = try? SimpleModel.decode(json)
    }

    func testDecodingModel() {
        XCTAssertEqual(model?.key, dict["key"] as? String)
        XCTAssertEqual(model?.number, dict["number"] as? Int)
        XCTAssertEqual(model?.bool, dict["bool"] as? Bool)
        XCTAssertEqual(model?.defaultItem, "Default")
        XCTAssertEqual(model?.nestedKey, "here")
    }

    func testDecodingNestedKeys() throws {
        let nestedKey: String = try json.decode("nestedKey.is")
        XCTAssertEqual(nestedKey, "here")
    }

    static var allTests = [
        ("testDecodingModel", testDecodingModel),
        ("testDecodingNestedKey", testDecodingNestedKeys),
    ]
}
