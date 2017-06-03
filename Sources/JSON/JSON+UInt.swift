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
}

