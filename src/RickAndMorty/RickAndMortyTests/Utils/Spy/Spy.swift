import Foundation
import os

public typealias SpyParamsForCall = [Any?]?
typealias SpyRegisteredCall = (String, SpyParamsForCall)

public final class Spy {

    private var paramHistory: [SpyRegisteredCall] = []

    public init() {}

    public func addCallToHistory(call: String, params: SpyParamsForCall = nil) {
        os_log("☎️ Call: %{PRIVATE}@",
               log: OSLog.default,
               type: .info,
               call)
        let callToRegister: SpyRegisteredCall = (call, params)
        paramHistory.append(callToRegister)
    }

    public func wasCallPerformed(call: String) -> Bool {

        let matchingCalls = self.matchingCalls(of: call)
        return !matchingCalls.isEmpty
    }

    private func matchingCalls(of call: String) -> [SpyRegisteredCall] {
        return paramHistory.filter { $0.0 == call }
    }

    public func matchingCallsCount(of call: String) -> Int {
        return matchingCalls(of: call).count
    }

    public func callHistoryCount() -> Int {
        return paramHistory.count
    }

    public func didReceive(param: Any?) -> Bool {
        guard let param = param else {
            return false
        }

        let flatParams = paramHistory
            .compactMap { $0.1?.compactMap { $0 } }
            .flatMap { $0 }

        let matchingParams = flatParams
            .filter { SpyComparer.compare(param1: param, param2: $0) }

        return !matchingParams.isEmpty
    }

    public func didReceive(param: Any?, forCall: String) -> Bool {
        guard let param = param else {
            return false
        }

        let matchingCalls = paramHistory
            .filter { forCall == $0.0 }

        let paramsFromMatchingCalls = matchingCalls
            .compactMap { $0.1?.compactMap { $0 } }

        let matchingParams = paramsFromMatchingCalls
            .flatMap { $0 }
            .filter {
                SpyComparer.compare(param1: param, param2: $0)
        }

        return !matchingParams.isEmpty
    }

    public func parametersForCall(call: String) -> [SpyParamsForCall] {
        let matchingCalls = paramHistory
            .filter { call == $0.0 }

        return matchingCalls.map { (_, params) -> SpyParamsForCall in
            return params
        }
    }

    public func parameter<T>(atPosition position: Int, call: String) -> T? {
        guard let parametersForLastCall = parametersForCall(call: call).last,
              let parameters = parametersForLastCall,
              parameters.indices.contains(position) else {
            return nil
        }

        return parameters[position] as? T
    }

    public func printCallHistory() {
        paramHistory
            .enumerated()
            .forEach {
                print("Call \($0.offset): <" + $0.element.0 + ">")
        }
    }

    public func callHistory() -> String {
        return paramHistory
            .map { "<" + $0.0 + ">" }
            .joined(separator: ", ")
    }

    public func resetSpy() {
        paramHistory.removeAll()
    }
}
