import Foundation

public struct JSON {
    private enum Node {
        case number
        case string
        case bool
        case array
        case dictionary
        case null
        case unknown
    }

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
        } catch {
            return nil
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
            return value(for: key)
        }
    }


    /// Retrieve a value from a given keyPath
    ///
    /// - Parameter keyPath: A keyPath to where an item could be
    /// - Returns: Iff an object is found, it will be boxed up in JSON
    public func value(for keyPath: String) -> JSON? {
        /**
         NSDictionary is used because it currently performs better than a native Swift dictionary.
         The reason for this is that [String : AnyObject] is bridged to NSDictionary deep down the
         call stack, and this bridging operation is relatively expensive. Until Swift is ABI stable
         and/or doesn't require a bridge to Objective-C, NSDictionary will be used here
         */
        guard let dictionary = object as? NSDictionary, let value = dictionary.value(forKeyPath: keyPath) else {
            return nil
        }

        return JSON(value)
    }

    public var rawString: String {
        guard let object = object else {
            return ""
        }

        switch type {
        case .array, .dictionary:
            guard let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) else {
                return ""
            }

            return String(data: data, encoding: String.Encoding.utf8) ?? ""
        default:
            return object as? String ?? ""
        }
    }

    private var type: Node {
        guard let object = object else {
            return .unknown
        }

        switch object {
        case is String:
            return .string
        case is NSArray:
            return .array
        case is NSDictionary:
            return .dictionary
        case is Int, is Float, is Double:
            return .number
        case is Bool:
            return .bool
        case is NSNull:
            return .null
        default:
            return .unknown
        }
    }
}

