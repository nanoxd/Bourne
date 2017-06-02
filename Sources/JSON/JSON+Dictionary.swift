import Foundation

extension JSON {
    public var dictionary: [String: JSON]? {
        guard let dictionary = object as? [String : Any] else {
            return nil
        }
        
        return Dictionary(dictionary.map { ($0, JSON($1)) })
    }
    
    public var dictionaryValue: [String: JSON] {
        return dictionary ?? [:]
    }
}
