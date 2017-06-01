import Foundation

extension JSON {
    public var string: String? {
        guard let object = object else {
            return nil
        }

        var value: String? = nil
        switch object {
        case is String:
            value = object as? String
        case is NSDecimalNumber:
            value = (object as? NSDecimalNumber)?.stringValue
        case is NSNumber:
            value = (object as? NSNumber)?.stringValue
        default:
            break
        }
        
        return value
    }
}
