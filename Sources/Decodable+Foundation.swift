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
