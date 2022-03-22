@testable import RickAndMorty
import XCTest

final class CharacterDetailConfiguratorMock {

    let spy = Spy()

    enum Calls {
        static let prepareScene = "prepareScene(with:)"
    }
}

extension CharacterDetailConfiguratorMock: CharacterDetailConfiguratorInterface {

    func prepareScene(with character: Character) -> UIViewController? {
        spy.addCallToHistory(call: #function, params: [character])
        return UIViewController()
    }
}
