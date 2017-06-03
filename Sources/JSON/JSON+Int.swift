import Foundation

extension JSON {
    public var int: Int? {
        guard let object = object else {
            return nil
        }
        
        var value: Int? = nil
        
        switch object {
        case is NSNumber:
            value = (object as? NSNumber)?.intValue
        case is String:
            let stringValue = object as? String
            if let stringValue = stringValue {
                value = Int(stringValue)
            }
        default:
            break
        }
        
        return value
    }
}
