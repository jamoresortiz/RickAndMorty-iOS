import Foundation

class SpyComparer {

    static func compare(param1: Any, param2: Any) -> Bool {

        guard let comparable1 = param1 as? SpyComparableInterface,
            let comparable2 = param2 as? SpyComparableInterface else {
                return compareBasicType(param1: param1, param2: param2)
        }

        return comparable1.isEqual(to: comparable2)
    }

    static func isBasicType(param: Any) -> Bool {

        if param is Int {
            return true
        }

        if param is Double {
            return true
        }

        if param is String {
            return true
        }

        if param is Float {
            return true
        }

        if param is Bool {
            return true
        }

        if param is [Any] {
            return true
        }

        if param is AnyHashable {
            return true
        }

        if param is [String: String] {
            return true
        }

        if param is [String: Any] {
            return true
        }

        if param is [AnyHashable: String] {
            return true
        }

        return false
    }

    static func compareBasicType(param1: Any, param2: Any) -> Bool {

        guard isBasicType(param: param1) else {
            return false
        }

        guard isBasicType(param: param2) else {
            return false
        }

        if let param1Int: Int = paramAs(param: param1),
            let param2Int: Int = paramAs(param: param2) {
            return param1Int == param2Int

        } else if let param1Int: Double = paramAs(param: param1),
            let param2Int: Double = paramAs(param: param2) {
            return param1Int == param2Int

        } else if let param1Int: String = paramAs(param: param1),
            let param2Int: String = paramAs(param: param2) {
            return param1Int == param2Int

        } else if let param1Int: Float = paramAs(param: param1),
            let param2Int: Float = paramAs(param: param2) {
            return param1Int == param2Int

        } else if let param1Bool: Bool = paramAs(param: param1),

            let param2Bool: Bool = paramAs(param: param2) {
            return param1Bool == param2Bool

        } else if let param1Dict: [String: String] = paramAs(param: param1),

            let param2Dict: [String: String] = paramAs(param: param2) {
            return param1Dict == param2Dict

        } else if let param1Dict: [String: Any] = paramAs(param: param1),
            let param2Dict: [String: Any] = paramAs(param: param2) {
            return param1Dict == param2Dict
        } else if let param1Array = param1 as? [Any],
            let param2Array = param2 as? [Any] {

            guard param1Array.count == param2Array.count else {
                return false
            }

            return zip(param1Array, param2Array).allSatisfy { compare(param1: $0, param2: $1) }
        } else if let param1Dict: [AnyHashable: String] = paramAs(param: param1),
            let param2Dict: [AnyHashable: String] = paramAs(param: param2) {
            return param1Dict == param2Dict

        } else if let param1Hashable: AnyHashable = paramAs(param: param1),
            let param2Hashable: AnyHashable = paramAs(param: param2) {
            return param1Hashable == param2Hashable
        }

        return false
    }
}

private extension SpyComparer {

    static func paramAs<T>(param: Any) -> T? {
        return param as? T
    }

}
