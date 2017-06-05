import Foundation

public protocol Decodable {
    /// Decodes JSON into conforming type
    static func decode(_ j: JSON?) throws -> Self
}
