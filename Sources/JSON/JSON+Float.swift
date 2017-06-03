import Foundation

extension JSON {
    public var float: Float? {
        guard let object = object else {
            return nil
        }
        
        var value: Float? = nil
        
        switch object {
        case is NSNumber:
            value = (object as? NSNumber)?.floatValue
        case is String:
            let stringValue = object as? String
            if let stringValue = stringValue {
                value = Float(stringValue)
            }
        default:
            break
        }
        
        return value
    }
}
