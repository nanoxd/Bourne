import Foundation

extension String: Mappable {
    public static func decode(_ j: JSON) throws -> String {
        guard let value = j.string else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to String")
        }

        return value
    }
}

extension Int: Mappable {
    public static func decode(_ j: JSON) throws -> Int {
        guard let value = j.int else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to Int")
        }

        return value
    }
}

extension Int64: Mappable {
    public static func decode(_ j: JSON) throws -> Int64 {
        guard let value = j.int64 else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to Int64")
        }

        return value
    }
}

extension UInt: Mappable {
    public static func decode(_ j: JSON) throws -> UInt {
        guard let value = j.uInt else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to UInt")
        }

        return value
    }
}

extension UInt64: Mappable {
    public static func decode(_ j: JSON) throws -> UInt64 {
        guard let value = j.uInt64 else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to UInt64")
        }

        return value
    }
}

extension Float: Mappable {
    public static func decode(_ j: JSON) throws -> Float {
        guard let value = j.float else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to Float")
        }

        return value
    }
}

extension Double: Mappable {
    public static func decode(_ j: JSON) throws -> Double {
        guard let value = j.double else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to Double")
        }

        return value
    }
}

extension Bool: Mappable {
    public static func decode(_ j: JSON) throws -> Bool {
        guard let value = j.bool else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to Bool")
        }

        return value
    }
}

extension URL: Mappable {
    public static func decode(_ j: JSON) throws -> URL {
        guard let value = j.url else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to URL")
        }

        return value
    }
}

extension Array where Element: Mappable {
    public static func decode(_ j: JSON) throws -> [Element] {
        guard let items = j.array else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to Array")
        }

        return try items.map { try Element.decode($0) }
    }
}

// MARK: - Dictionary
extension ExpressibleByDictionaryLiteral where Value: Mappable {
    public  static func decode(_ j: JSON) throws -> [String: Value] {
        guard let dict = j.dictionary else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to Dictionary")
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
    public static func decode(_ j: JSON) throws -> NSDictionary {
        guard let dict = j.object, let result = dict as? NSDictionary else {
            throw BourneError.undecodable("Could not convert \(String(describing: j)) to NSDictionary")
        }

        return result
    }
}
