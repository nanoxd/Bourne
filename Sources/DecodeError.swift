import Foundation

public enum DecodeError: Error {
    case emptyJSON(String)
    case undecodable(String)
}
