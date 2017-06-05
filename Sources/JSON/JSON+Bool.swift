import Foundation

extension JSON {
    /// A boolean value for the current object
    public var bool: Bool? {
        guard let object = object else {
            return nil
        }

        var value: Bool? = nil

        switch object {
        // Handles regular booleans and 0/>1
        case is NSNumber: 
            value = (object as? NSNumber)?.boolValue
        case is String:
            let stringValue = object as? String

            value = stringValue.flatMap(Bool.init)
        default:
            break
        }
        
        return value
    }
}
