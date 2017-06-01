import Foundation


/// A union types that describes the possible permutations of the JSON spec
public enum JSONType: Int {
    /// A number contains an integer component that may be prefixed with an optional minus sign, which may be followed by a fraction part and/or an exponent part.
    /// Octal and hex forms are not allowed.  Leading zeros are not allowed.
    case number

    case string
    case bool
    case array
    case dictionary
    case null
    case unknown
}
