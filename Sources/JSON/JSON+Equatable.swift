import Foundation

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
        return Dictionary(left.map { ($0.0, JSON($0.1)) }) == Dictionary(right.map { ($0.0, JSON($0.1)) })
        
    default: return false
    }
}

