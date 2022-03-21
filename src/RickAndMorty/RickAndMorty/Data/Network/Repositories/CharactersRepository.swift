import RxSwift
import Moya

public final class CharactersRepository {

    private let provider: Moya.MoyaProvider<CharactersTarget>

    public init(provider: Moya.MoyaProvider<CharactersTarget>) {
        self.provider = provider
    }
}

extension CharactersRepository: CharactersRepositoryInterface {

    public func getCharacters(with page: Int) -> Single<Characters> {
        return provider.rx
            .request(.getCharacters(page: page))
            .catchError { _ in
                return .error(NetworkError.someError)
            }
            .filterSuccessfulStatusAndRedirectCodes()
            .map(CharactersResponse.self)
            .flatMap {
                if let characters = CharactersMapper.mapToCharacters(from: $0) {
                    return .just(characters)
                }
                return .error(NetworkError.someError)
            }
    }
}
