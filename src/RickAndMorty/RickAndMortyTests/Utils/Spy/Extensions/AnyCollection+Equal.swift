import Foundation

extension Array where Element: Any {
    static func == (left: [Element], right: [Element]) -> Bool {
        if left.count != right.count {
            return false

        }
        for (index, leftValue) in left.enumerated() {
            guard areEqual(leftValue, right[index]) else {
                return false
            }
        }
        return true
    }

    static func != (left: [Element], right: [Element]) -> Bool {
        return !(left == right)
    }
}

extension Dictionary where Value: Any {
    static func == (left: [Key: Value], right: [Key: Value]) -> Bool {
        if left.count != right.count {
            return false
        }

        for element in left {
            guard let rightValue = right[element.key],
                areEqual(rightValue, element.value) else { return false }
        }
        return true
    }

    static func != (left: [Key: Value], right: [Key: Value]) -> Bool {
        return !(left == right)
    }
}

private func areEqual (_ left: Any, _ right: Any) -> Bool {
    if type(of: left) == type(of: right) && String(describing: left) == String(describing: right) {
        return true
    }

    if let left = left as? [Any], let right = right as? [Any] {
        return left == right
    }

    if let left = left as? [AnyHashable: Any], let right = right as? [AnyHashable: Any] {
        return left == right
    }

    return false
}
