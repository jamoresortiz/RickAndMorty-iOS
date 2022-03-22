@testable import RickAndMorty
import XCTest
import RxSwift

final class CharacterListInteractorMock {

    let spy = Spy()
    var getCharactersResult: Single<Characters>!
    var getFavCharactersResult: [Character]!

    enum Calls {
        static let getCharacters = "getCharacters(with:)"
        static let getFavCharacters = "getFavCharacters()"
        static let saveFav = "saveFav(character:)"
        static let deleteFav = "deleteFav(character:)"
    }

    var deleteFavExpectation: XCTestExpectation?
}

extension CharacterListInteractorMock: CharacterListInteractorInterface {

    func getCharacters(with page: Int) -> Single<Characters> {
        spy.addCallToHistory(call: #function, params: [page])
        return getCharactersResult
    }

    func getFavCharacters() -> [Character] {
        spy.addCallToHistory(call: #function)
        return getFavCharactersResult
    }

    func saveFav(character: Character) {
        spy.addCallToHistory(call: #function, params: [character])
    }

    func deleteFav(character: Character) {
        spy.addCallToHistory(call: #function, params: [character])
        deleteFavExpectation?.fulfill()
    }
}
