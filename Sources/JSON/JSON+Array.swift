import Foundation

extension JSON {
    /// An optional array of the current JSON object
    public var array: [JSON]? {
        guard let array = object as? [Any] else {
            return nil
        }
        
        return array.map { JSON($0) }
    }

    /// The contents of the current object or an empty array
    public var arrayValue: [JSON] {
        return array ?? []
    }
}

// MARK: - ArrayLiteralConvertible
extension JSON: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Any...) {
        self.init(elements)
    }
}

