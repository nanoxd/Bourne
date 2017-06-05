import Foundation

// Can be revisted when Integer is represented by a protocol
extension JSON {
    public var uInt: UInt? {
        guard let object = object else {
            return nil
        }
        
        var value: UInt? = nil

        switch object {
        case is Int:
            value = (object as? Int).flatMap(UInt.init)
        case is NSNumber:
            value = (object as? NSNumber)?.uintValue
        case is String:
            let stringValue = object as? String
            if let stringValue = stringValue {
                value = UInt(stringValue)
            }
        default:
            break
        }
        
        return value
    }

    public var uInt64: UInt64? {
        guard let object = object else {
            return nil
        }

        var value: UInt64? = nil

        switch object {
        case is Int:
            value = (object as? Int).flatMap { UInt64(exactly: $0) }
        case is Int64:
            value = (object as? Int64).flatMap { UInt64(exactly: $0) }
        case is NSNumber:
            value = (object as? NSNumber)?.uint64Value
        case is String:
            let stringValue = object as? String
            if let stringValue = stringValue {
                value = UInt64(stringValue)
            }
        default:
            break
        }
        
        return value
    }
}

