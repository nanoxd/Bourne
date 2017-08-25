import Foundation

public protocol Mappable {
    /// Decodes JSON into conforming type
    static func decode(_ j: JSON) throws -> Self
}
