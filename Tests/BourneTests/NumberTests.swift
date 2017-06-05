import Foundation
import XCTest
@testable import Bourne

class NumberTests: XCTestCase {
    func testIntExtensionDecoding() throws {
        let int = try Int.decode(JSON(1))
        let otherInt = JSON(1).int
        let stringInt = JSON("1").int

        XCTAssertEqual(int, 1)
        XCTAssertEqual(otherInt, 1)
        XCTAssertEqual(stringInt, 1)
        
        XCTAssertNil(JSON().int)
        XCTAssertNil(JSON([1]).int)
    }

    func testIntExtensionThrowsError() {
        let json = JSON()
        XCTAssertThrowsError(try Int.decode(json))
    }

    func testIntEquality() {
        let lhs = JSON(1)
        let rhs = JSON(1)

        XCTAssertEqual(lhs, rhs)

        let one = JSON(1)
        let two = JSON(2)
        XCTAssertNotEqual(one, two)

        let stringOne = JSON("1")
        XCTAssertNotEqual(stringOne, one)
    }
    
    func testInt64Decoding() {
        let int64 = Int64.max
        XCTAssertEqual(JSON(int64).int64, int64)
        
        let stringInt64 = String(describing: int64)
        XCTAssertEqual(JSON(stringInt64).int64, int64)
        
        XCTAssertNil(JSON().int64)
        XCTAssertNil(JSON([]).int64)
    }
    
    func testInt64Extension() throws {
        let int64 = Int64.max
        XCTAssertThrowsError(try Int64.decode(JSON()))
        XCTAssertEqual(try Int64.decode(JSON(int64)), int64)
    }
    
    func testInt64Equality() {
        let lhs = JSON(Int64.max)
        let rhs = JSON(Int64.max)
        
        XCTAssertEqual(lhs, rhs)
    }

    func testDoubleDecoding() {
        let double = 1.211
        let stringDouble = "1.211"

        XCTAssertEqual(JSON(double).double, double)
        XCTAssertEqual(JSON(stringDouble).double, double)
        XCTAssertEqual(JSON(1).double, 1.0)
    }

    func testInvalidDoubleDecoding() {
        XCTAssertNil(JSON(nil).double)
        XCTAssertNil(JSON([]).double)
    }

    func testDoubleEquality() {
        let lhs = JSON(1.0)
        let rhs = JSON(1.0)

        XCTAssertEqual(lhs, rhs)

        let morePrecision = JSON(1.12121212)
        let andAgain = JSON(1.1212121)

        XCTAssertNotEqual(morePrecision, andAgain)
    }

    func testDoubleExtensionThrows() throws {
        XCTAssertThrowsError(try Double.decode(JSON([])))
    }

    func testDoubleExtension() throws {
        let json = JSON(1.21)
        let double = try Double.decode(json)

        XCTAssertEqual(double, 1.21)
    }

    func testUIntDecoding() {
        let uInt: UInt = 121
        let uIntJson = JSON(uInt)

        XCTAssertEqual(uIntJson.uInt, uInt)
        
        let negativeInt = -124
        let negativeJson = JSON(negativeInt)
        XCTAssertNil(negativeJson.uInt)
        
        let stringUInt = "121"
        XCTAssertEqual(JSON(stringUInt).uInt, uInt)
        
        let double = 1.21
        XCTAssertEqual(JSON(double).uInt, 1)
        
        XCTAssertNil(JSON().uInt)
        XCTAssertNil(JSON([]).uInt)
    }
    
    func testUIntExtension() throws {
        let uInt: UInt = 121
        XCTAssertEqual(try UInt.decode(JSON(uInt)), uInt)
        
        XCTAssertThrowsError(try UInt.decode(JSON()))
    }
    
    func testUIntEquality() {
        let uInt: UInt = 121
        XCTAssertEqual(JSON(uInt), JSON(uInt))
        XCTAssertNotEqual(JSON(uInt), JSON(101))
    }

    func testUInt64Decoding() {
        let uInt = UInt64.max
        let uIntJson = JSON(uInt)

        XCTAssertEqual(uIntJson.uInt64, uInt)

        let negativeInt = -124
        let negativeJson = JSON(negativeInt)
        XCTAssertNil(negativeJson.uInt64)

        let stringUInt = String(describing: uInt)
        XCTAssertEqual(JSON(stringUInt).uInt64, uInt)
        
        let double = 1.21
        XCTAssertEqual(JSON(double).uInt64, 1)
        
        XCTAssertNil(JSON().uInt64)
        XCTAssertNil(JSON([]).uInt64)
    }

    func testUInt64Equality() {
        let uInt: UInt64 = UInt64.max
        XCTAssertEqual(JSON(uInt), JSON(uInt))
        XCTAssertNotEqual(JSON(uInt), JSON(101))
    }
    
    func testFloatDecoding() {
        let float: Float = 1.1
        XCTAssertEqual(JSON(float).float, float)
        
        let stringFloat = "1.1"
        XCTAssertEqual(JSON(stringFloat).float, float)
        
        XCTAssertNil(JSON().float)
        XCTAssertNil(JSON([]).float)
        
        XCTAssertEqual(JSON(1).float, 1.0)
    }
    
    func testFloatExtension() throws {
        XCTAssertThrowsError(try Float.decode(JSON()))
        
        let float: Float = 1.1
        XCTAssertEqual(try Float.decode(JSON(float)), float)
    }
    
    func testFloatEquality() {
        let float: Float = 1.1
        XCTAssertEqual(JSON(float), JSON(float))
        XCTAssertNotEqual(JSON(float), JSON(1.3))
    }

    static var allTests = [
        ("testIntExtensionDecoding", testIntExtensionDecoding),
        ("testIntExtensionThrowsError", testIntExtensionThrowsError),
        ("testIntEquality", testIntEquality),
        ("testInt64Decoding", testInt64Decoding),
        ("testInt64Extension", testInt64Extension),
        ("testInt64Equality", testInt64Equality),
        ("testDoubleDecoding", testDoubleDecoding),
        ("testDoubleEquality", testDoubleEquality),
        ("testDoubleExtension", testDoubleExtension),
        ("testDoubleExtensionThrows", testDoubleExtensionThrows),
        ("testInvalidDoubleDecoding", testInvalidDoubleDecoding),
        ("testUIntDecoding", testUIntDecoding),
        ("testUIntExtension", testUIntExtension),
        ("testUIntEquality", testUIntEquality),
        ("testUInt64Decoding", testUInt64Decoding),
        ("testUInt64Equality", testUInt64Equality),
        ("testFloatDecoding", testFloatDecoding),
        ("testFloatExtension", testFloatExtension),
        ("testFloatEquality", testFloatEquality),
    ]
}
