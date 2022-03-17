import Moya

public enum CharactersTarget {
    case getCharacters(page: Int)
}

extension CharactersTarget: Moya.TargetType {

    public var baseURL: URL {
        guard
            let url = URL(string: Environment.characterBaseURL)
        else {
            fatalError("BaseURL can not be configured")
        }
        return url
    }

    public var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        }
    }

    public var method: Method {
        switch self {
        case .getCharacters:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case let .getCharacters(page):
            return .requestParameters(
                parameters: ["page" : page],
                encoding: URLEncoding.default
            )
        }
    }

    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
