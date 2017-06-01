import Foundation

extension String: Decodable {
    public static func decode(_ json: JSON?) throws -> String {
        guard let value = json?.string else {
            throw DecodeError.undecodable("Could not convert \(String(describing: json)) to String")
        }

        return value
    }
}

