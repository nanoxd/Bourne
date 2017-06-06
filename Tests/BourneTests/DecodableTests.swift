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
    let numbers: [Int]

    static func decode(_ j: JSON?) throws -> SimpleModel {
        guard let j = j else { throw TestError.invalidJSON }
        return SimpleModel(
            key: try j.decode("key"),
            number: try j.decode("number"),
            bool: try j.decode("bool"),
            nestedKey: try j.decode("nestedKey.is"),
            defaultItem: try j.decode("invalidKey", or: "Default"),
            numbers: try j.decode("numbers")
        )
    }
}

class DecodableTests: XCTestCase {
    let dict: [String: Any] = [
        "key": "value",
        "number": 1024,
        "bool": false,
        "nestedKey": ["is": "here"],
        "numbers": [1, 2, 3],
        "person": ["name": "Alfred", "age": 18],
        "queue": ["Alfred": 1, "Maria": 2, "Jose": 3, "Consuelo": 4]
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
        XCTAssertEqual((model?.numbers)!, [1, 2, 3])
    }

    func testDecodingWithDefaultValue() throws {
        let invalidKey: Int = try json.decode("invalidKey", or: 1)

        XCTAssertEqual(invalidKey, 1)

        let invalidArray: [String] = try json.decode("invalidArray", or: ["one"])
        XCTAssertEqual(invalidArray, ["one"])
        XCTAssertEqual(invalidArray.count, 1)

        let invalidDictionary: [String: Bool] = try json.decode("invalidDict", or: ["yes": true, "no": false])
        XCTAssertEqual(invalidDictionary.count, 2)
        XCTAssertEqual(invalidDictionary, ["yes": true, "no": false])
    }

    func testDecodingNestedKeys() throws {
        let nestedKey: String = try json.decode("nestedKey.is")
        XCTAssertEqual(nestedKey, "here")
    }

    func testDecodingArray() throws {
        let numbers: [Int] = try json.decode("numbers")
        XCTAssertEqual(numbers, [1, 2, 3])
        XCTAssertEqual(numbers.count, 3)
    }

    func testDecodingDictionary() throws {
        let queue: [String: Int] = try json.decode("queue")

        XCTAssertEqual(queue.count, 4)
        XCTAssertEqual(queue["Alfred"], 1)
    }

    static var allTests = [
        ("testDecodingModel", testDecodingModel),
        ("testDecodingWithDefaultValue", testDecodingWithDefaultValue),
        ("testDecodingNestedKey", testDecodingNestedKeys),
        ("testDecodingArray", testDecodingArray),
    ]
}
