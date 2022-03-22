@testable import RickAndMorty

final class LocalProviderMock {

    let spy = Spy()

    var getFavCharactersResult: [Character]!

    enum Calls {
        static let saveFav = "saveFav(character:)"
        static let deleteFav = "deleteFav(character:)"
        static let getFavCharacters = "getFavCharacters()"
    }
}

extension LocalProviderMock: LocalProviderInterface {

    func saveFav(character: Character) {
        spy.addCallToHistory(call: #function, params: [character])
    }

    func deleteFav(character: Character) {
        spy.addCallToHistory(call: #function, params: [character])
    }

    func getFavCharacters() -> [Character] {
        spy.addCallToHistory(call: #function)
        return getFavCharactersResult
    }
}
