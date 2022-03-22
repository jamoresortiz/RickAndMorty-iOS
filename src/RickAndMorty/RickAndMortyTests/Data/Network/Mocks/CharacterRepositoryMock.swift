@testable import RickAndMorty
import RxSwift

final class CharacterRepositoryMock {

    let spy = Spy()
    var getCharactersResult: Single<Characters>!

    enum Calls {
        static let getCharacters = "getCharacters(with:)"
    }
}

extension CharacterRepositoryMock: CharactersRepositoryInterface {

    func getCharacters(with page: Int) -> Single<Characters> {
        spy.addCallToHistory(call: #function, params: [page])
        return getCharactersResult
    }
}
