import Foundation

public struct JSON {
    public var object: Any?

    public init() {
        self.object = nil
    }

    /// Initializes an instance with Any object
    ///
    /// - Parameter object: Any
    public init(_ object: Any?) {
        self.object = object
    }



    /// Initializes an instance with another JSON object
    ///
    /// - Parameter json: A JSON object
    public init(json: JSON) {
        self.object = json.object
    }

    public init?(data: Data?) {
        guard let data = data else {
            return nil
        }
        
        do {
            let object: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            self.object = object
        } catch let error as NSError {
            debugPrint(error)
        }
    }

    public init?(path: String) {
        guard FileManager.default.fileExists(atPath: path) else {
            return nil
        }

        let data = try? Data(contentsOf: Foundation.URL(fileURLWithPath: path))
        
        self.init(data: data)
    }
    
    /**
     Initialize an instance given a JSON file contained within the bundle.
     
     - parameter bundle: The bundle to attempt to load from.
     - parameter string: A string containing the name of the file to load from resources.
     */
    public init?(bundleClass: AnyClass, filename: String) {
        let bundle = Bundle(for: bundleClass)
        
        self.init(bundle: bundle, filename: filename)
    }

    public init?(bundle: Bundle, filename: String) {
        guard let filePath = bundle.path(forResource: filename, ofType: nil) else {
            return nil
        }
        
        self.init(path: filePath)
    }
    
    public subscript(key: String) -> JSON? {
        set {
            if var tempObject = object as? [String : Any] {
                tempObject[key] = newValue?.object
                self.object = tempObject
            } else {
                var tempObject: [String : Any] = [:]
                tempObject[key] = newValue?.object
                self.object = tempObject
            }
        }

        get {
            /**
             NSDictionary is used because it currently performs better than a native Swift dictionary.
             The reason for this is that [String : AnyObject] is bridged to NSDictionary deep down the
             call stack, and this bridging operation is relatively expensive. Until Swift is ABI stable
             and/or doesn't require a bridge to Objective-C, NSDictionary will be used here
             */
            guard let dictionary = object as? NSDictionary, let value = dictionary[key] else {
                return nil
            }
            
            return JSON(value)
        }
    }
}

// MARK: - JSON+String

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

// MARK: - Int
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
                value = NSDecimalNumber(string: stringValue).intValue
            }
        default:
            break
        }
        
        return value
    }
}

// MARK: Equatable
extension JSON: Equatable {}

public func ==(lhs: JSON, rhs: JSON) -> Bool {
    guard let lhsObject: Any = lhs.object, let rhsObject: Any = rhs.object else {
        return false
    }

    switch (lhsObject, rhsObject) {
    case (let left as String, let right as String):
        return left == right
    case (let left as Double, let right as Double):
        return left == right
    case (let left as Float, let right as Float):
        return left == right
    case (let left as Int, let right as Int):
        return left == right
    case (let left as Int64, let right as Int64):
        return left == right
    case (let left as UInt, let right as UInt):
        return left == right
    case (let left as UInt64, let right as UInt64):
        return left == right
    case (let left as Bool, let right as Bool):
        return left == right
    case (let left as [Any], let right as [Any]):
        return left.map { JSON($0) } == right.map { JSON ($0) }
    case (let left as [String : Any], let right as [String : Any]):
        return Dictionary(left.map { ($0, JSON($1)) }) == Dictionary(right.map { ($0, JSON($1)) })
        
    default: return false
    }
}


