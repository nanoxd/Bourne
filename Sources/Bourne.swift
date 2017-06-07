import Foundation

public enum BourneError: Error {
    case emptyJSON(String)
    case undecodable(String)
}
