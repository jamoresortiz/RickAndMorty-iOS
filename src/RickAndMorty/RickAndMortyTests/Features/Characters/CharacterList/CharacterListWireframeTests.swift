@testable import RickAndMorty
import XCTest

final class CharacterListWireframeTests: XCTestCase {

    var sut: CharacterListWireframe!
    var viewControllerSpy: UIViewControllerSpy!
    var navigationControllerSpy: UINavigationControllerSpy!
    var characterDetailConfiguratorMock: CharacterDetailConfiguratorMock!

    override func setUp() {
        super.setUp()
        characterDetailConfiguratorMock = CharacterDetailConfiguratorMock()
        sut = .init(
            characterDetailConfiguratorInterface: characterDetailConfiguratorMock
        )
        viewControllerSpy = UIViewControllerSpy()
        navigationControllerSpy = UINavigationControllerSpy(
            rootViewController: viewControllerSpy
        )
        sut.view = viewControllerSpy
        navigationControllerSpy.spyReporter.resetSpy()
    }

    override func tearDown() {
        sut = nil
        viewControllerSpy = nil
        navigationControllerSpy = nil
        characterDetailConfiguratorMock = nil

        super.tearDown()
    }

    func testPresentDetail_whenCalled_thenPrepareCharacterDetail() {
        // Given
        let character = CharactersFactory.character

        // When
        sut.presentDetail(of: character)

        // Then
        XCTAssertTrue(
            characterDetailConfiguratorMock.spy.wasCallPerformed(
                call: CharacterDetailConfiguratorMock.Calls.prepareScene
            )
        )
    }

    func testPresentDetail_whenCalled_thenPresentCharacterDetail() {
        // Given
        let character = CharactersFactory.character

        // When
        sut.presentDetail(of: character)

        // Then
        XCTAssertTrue(
            viewControllerSpy.spyReporter.wasCallPerformed(
                call: UIViewControllerSpy.Calls.present
            )
        )
    }
}
