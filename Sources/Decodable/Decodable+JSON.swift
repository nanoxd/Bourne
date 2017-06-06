import Foundation

extension JSON {
    /// Decodes any `Decodable` type into itself or a default value
    ///
    /// - Parameters:
    ///   - key: JSON key path
    ///   - defaultValue: Value to default to when key is not present
    /// - Returns: The `Decodable` type
    /// - Throws: A DecodeError iff the key is empty and defaultValue is not defined
    func decode<T: Decodable>(_ key: String, or defaultValue: T? = nil) throws -> T {
        guard let value = try? T.decode(self[key]) else {
            if let defaultValue = defaultValue {
                return defaultValue
            } else {
                throw DecodeError.emptyJSON(key)
            }
        }
        
        return value
    }

    /// Decodes any `Decodable` type into an array of itself or a default value
    ///
    /// - Parameters:
    ///   - key: JSON key path
    ///   - defaultValue: Value to default to when key is not present
    /// - Returns: The `Decodable` type
    /// - Throws: A DecodeError iff the key is empty and defaultValue is not defined
    func decode<T: Decodable>(_ key: String, or defaultValues: [T]? = nil) throws -> [T] {
        guard let array = self[key]?.array else {
            if let defaultValues = defaultValues {
                return defaultValues
            } else {
                throw DecodeError.emptyJSON(key)
            }
        }

        return try array.map { json in
            guard let value = try? T.decode(json) else {
                throw DecodeError.emptyJSON(key)
            }

            return value
        }

    }

}
