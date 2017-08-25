import Foundation

extension JSON {
    public var dictionary: [String: JSON]? {
        guard let dictionary = object as? [String : Any] else {
            return nil
        }
        
        return Dictionary(dictionary.map { ($0.0, JSON($0.1)) })
    }
    
    public var dictionaryValue: [String: JSON] {
        return dictionary ?? [:]
    }
}

// MARK: - DictionaryLiteralConvertible

extension JSON: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, Any)...) {
        var object: [String : Any] = [:]

        for (key, value) in elements {
            object[key] = value
        }

        self.init(object)
    }
}
