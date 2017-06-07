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
}
