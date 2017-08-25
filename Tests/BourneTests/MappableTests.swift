import Foundation
import XCTest
@testable import Bourne

enum TestError: Error {
    case invalidJSON
}

struct SimpleModel: Mappable {
    let key: String
    let number: Int
    let bool: Bool
    let nestedKey: String
    let defaultItem: String
    let numbers: [Int]

    static func decode(_ j: JSON) throws -> SimpleModel {
        return SimpleModel(
            key: try j.from("key"),
            number: try j.from("number"),
            bool: try j.from("bool"),
            nestedKey: try j.from("nestedKey.is"),
            defaultItem: try j.from("invalidKey", or: "Default"),
            numbers: try j.from("numbers")
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
        let invalidKey: Int = try json.from("invalidKey", or: 1)

        XCTAssertEqual(invalidKey, 1)

        let invalidArray: [String] = try json.from("invalidArray", or: ["one"])
        XCTAssertEqual(invalidArray, ["one"])
        XCTAssertEqual(invalidArray.count, 1)

        let invalidDictionary: [String: Bool] = try json.from("invalidDict", or: ["yes": true, "no": false])
        XCTAssertEqual(invalidDictionary.count, 2)
        XCTAssertEqual(invalidDictionary, ["yes": true, "no": false])
    }

    func testDecodingNestedKeys() throws {
        let nestedKey: String = try json.from("nestedKey.is")
        XCTAssertEqual(nestedKey, "here")
    }

    func testDecodingArray() throws {
        let numbers: [Int] = try json.from("numbers")
        XCTAssertEqual(numbers, [1, 2, 3])
        XCTAssertEqual(numbers.count, 3)
    }

    func testDecodingDictionary() throws {
        let queue: [String: Int] = try json.from("queue")

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
