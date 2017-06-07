import Foundation

extension JSON {
    /// Decodes any `Mappable` type into itself or a default value
    ///
    /// - Parameters:
    ///   - key: JSON key path
    ///   - defaultValue: Value to default to when key is not present
    /// - Returns: The `Mappable` type
    /// - Throws: A DecodeError iff the key is empty and defaultValue is not defined
    func decode<T: Mappable>(_ key: String, or defaultValue: T? = nil) throws -> T {
        guard let json = self[key], let value = try? T.decode(json) else {
            if let defaultValue = defaultValue {
                return defaultValue
            } else {
                throw BourneError.emptyJSON(key)
            }
        }
        
        return value
    }

    /// Decodes any `Mappable` type into an array of itself or a default value
    ///
    /// - Parameters:
    ///   - key: JSON key path
    ///   - defaultValues: Value to default to when key is not present
    /// - Returns: An array of `Mappable` types
    /// - Throws: A DecodeError iff the key is empty and defaultValue is not defined
    func decode<T: Mappable>(_ key: String, or defaultValues: [T]? = nil) throws -> [T] {
        guard let array = self[key]?.array else {
            if let defaultValues = defaultValues {
                return defaultValues
            } else {
                throw BourneError.emptyJSON(key)
            }
        }

        return try array.map { json in
            guard let value = try? T.decode(json) else {
                throw BourneError.emptyJSON(key)
            }

            return value
        }
    }

    /// Decodes any `Decodable` type into an array of itself or a default value
    ///
    /// - Parameters:
    ///   - key: JSON key path
    ///   - defaultValue: Value to default to when key is not present
    /// - Returns: A dictionary of  `String: Decodable` types
    /// - Throws: A DecodeError iff the key is empty and defaultValue is not defined
    func decode<Value: Mappable>(_ key: String, or defaultValue: [String: Value]? = nil) throws -> [String: Value] {
        var dict = [String: Value]()

        guard let value = self[key], let dictionary = value.dictionary else {
            if let defaultValue = defaultValue {
                return defaultValue
            } else {
                throw BourneError.emptyJSON(key)
            }
        }

        for (key, value) in dictionary {
            dict[key] = try? Value.decode(value)
        }

        return dict
    }
}
