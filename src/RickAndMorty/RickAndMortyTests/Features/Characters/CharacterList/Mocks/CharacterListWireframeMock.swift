@testable import RickAndMorty
import XCTest

final class CharacterListWireframeMock {

    let spy = Spy()
    enum Calls {
        static let presentDetail = "presentDetail(of:)"
    }
}

extension CharacterListWireframeMock: CharacterListWireframeInterface {

    func presentDetail(of character: Character) {
        spy.addCallToHistory(call: #function)
    }
}
