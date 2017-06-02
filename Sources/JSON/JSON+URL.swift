import Foundation

extension JSON {
    public var url: URL? {
        return string.flatMap(URL.init)
    }
}

