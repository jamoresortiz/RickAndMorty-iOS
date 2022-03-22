@testable import RickAndMorty
import XCTest
import RxSwift

final class CharacterListInteractorTests: XCTestCase {

    private typealias LocalProviderCalls = LocalProviderMock.Calls
    private typealias RepositoryCalls = CharacterRepositoryMock.Calls

    var sut: CharacterListInteractor!
    var characterRepositoryMock: CharacterRepositoryMock!
    var localProviderMock: LocalProviderMock!

    override func setUp() {
        super.setUp()

        characterRepositoryMock = CharacterRepositoryMock()
        localProviderMock = LocalProviderMock()
        sut = .init(
            charactersRepository: characterRepositoryMock,
            localProvider: localProviderMock
        )
    }

    override func tearDown() {
        sut = nil
        characterRepositoryMock = nil
        localProviderMock = nil

        super.tearDown()
    }

    func testGetCharacters_thenRepositoryGets() {
        // Given
        characterRepositoryMock.getCharactersResult = .just(CharactersFactory.characters)
        let page = 1

        // When
        _ = sut.getCharacters(with: page)

        // Then
        XCTAssertTrue(characterRepositoryMock.spy.wasCallPerformed(call: RepositoryCalls.getCharacters))
    }

    func testGetFavCharacters_thenLocalProviderGets() {
        // Given
        localProviderMock.getFavCharactersResult = CharactersFactory.characterList

        // When
        _ = sut.getFavCharacters()

        // Then
        XCTAssertTrue(localProviderMock.spy.wasCallPerformed(call: LocalProviderCalls.getFavCharacters))
    }

    func testSaveFavCharacter_thenLocalProviderSaves() {
        // Given
        let character = CharactersFactory.character

        // When
        sut.saveFav(character: character)

        // Then
        XCTAssertTrue(localProviderMock.spy.wasCallPerformed(call: LocalProviderCalls.saveFav))
    }

    func testDeleteFavCharacter_thenLocalProviderDeletes() {
        // Given
        let character = CharactersFactory.character

        // When
        sut.deleteFav(character: character)

        // Then
        XCTAssertTrue(localProviderMock.spy.wasCallPerformed(call: LocalProviderCalls.deleteFav))
    }
}
