import Foundation

extension JSON {
    public var double: Double? {
        guard let object = object else {
            return nil
        }

        var value: Double? = nil

        switch object {
        case is NSNumber:
            value = (object as? NSNumber)?.doubleValue
        case is String:
            let stringValue = object as? String
            
            if let stringValue = stringValue {
                value = Double(stringValue)
            }
        default:
            break
        }
        
        return value
    }
}
