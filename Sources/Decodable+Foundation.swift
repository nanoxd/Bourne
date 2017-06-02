import Foundation

extension String: Decodable {
    public static func decode(_ json: JSON?) throws -> String {
        guard let value = json?.string else {
            throw DecodeError.undecodable("Could not convert \(String(describing: json)) to String")
        }

        return value
    }
}

extension Int: Decodable {
    public static func decode(_ json: JSON?) throws -> Int {
        guard let value = json?.int else {
            throw DecodeError.undecodable("Could not convert \(String(describing: json)) to Int")
        }

        return value
    }
}

extension Double: Decodable {
    public static func decode(_ json: JSON?) throws -> Double {
        guard let value = json?.double else {
            throw DecodeError.undecodable("Could not convert \(String(describing: json)) to Double")
        }

        return value
    }
}

extension Bool: Decodable {
    public static func decode(_ json: JSON?) throws -> Bool {
        guard let value = json?.bool else {
            throw DecodeError.undecodable("Could not convert \(String(describing: json)) to Bool")
        }

        return value
    }
}

extension Array where Element: Decodable {
    public static func decode(_ json: JSON?) throws -> [Element] {
        guard let items = json?.array else {
            throw DecodeError.undecodable("Could not convert \(String(describing: json)) to Array")
        }

        return try items.map { try Element.decode($0) }
    }
}

// MARK: - Dictionary
extension ExpressibleByDictionaryLiteral where Value: Decodable {
    public  static func decode(_ json: JSON?) throws -> [String: Value] {
        guard let dict = json?.dictionary else {
            throw DecodeError.undecodable("Could not convert \(String(describing: json)) to Dictionary")
        }

        var decodedDict = [String: Value]()

        for (key, value) in dict {
            let decodedItem = try Value.decode(value)
            decodedDict[key] = decodedItem
        }

        return decodedDict
    }
}

extension NSDictionary {
    public static func decode(_ json: JSON?) throws -> NSDictionary {
        guard let dict = json?.object, let result = dict as? NSDictionary else {
            throw DecodeError.undecodable("Could not convert \(String(describing: json)) to NSDictionary")
        }
        
        return result
    }
}

