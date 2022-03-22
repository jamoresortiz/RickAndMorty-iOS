@testable import RickAndMorty
import XCTest

final class CharacterListPresenterTests: XCTestCase {

    var sut: CharacterListPresenter!
    var viewMock: CharacterListViewMock!
    var wireframeMock: CharacterListWireframeMock!
    var interactorMock: CharacterListInteractorMock!

    private typealias ViewCalls = CharacterListViewMock.Calls
    private typealias WireframeCalls = CharacterListWireframeMock.Calls
    private typealias InteractorCalls = CharacterListInteractorMock.Calls

    override func setUp() {
        super.setUp()
        wireframeMock = CharacterListWireframeMock()
        interactorMock = CharacterListInteractorMock()
        viewMock = CharacterListViewMock()

        sut = .init(
            wireframe: wireframeMock,
            interactor: interactorMock
        )
        sut.view = viewMock
    }

    override func tearDown() {
        sut = nil
        viewMock = nil
        interactorMock = nil
        wireframeMock = nil

        super.tearDown()
    }

    func testViewReady_whenCalled_thenGetCharacters() {
        // Given
        interactorMock.getCharactersResult = .error(NetworkError.someError)

        // When
        sut.viewReady()

        // Then
        XCTAssertTrue(interactorMock.spy.wasCallPerformed(call: InteractorCalls.getCharacters))
        XCTAssertTrue(viewMock.spy.wasCallPerformed(call: ViewCalls.showLoading))
    }

    func testViewReady_whenGetCharactersIsSuccess_thenFillTableView() {
        // Given
        interactorMock.getCharactersResult = .just(CharactersFactory.characters)
        interactorMock.getFavCharactersResult = []
        viewMock.fillTableViewExpectation = XCTestExpectation(description: "wait for fillTableView")

        // When
        sut.viewReady()

        // Then
        wait(for: [viewMock.fillTableViewExpectation!], timeout: 1.0)
    }

    func testViewReady_whenGetCharactersFails_thenShowErrorView() {
        // Given
        interactorMock.getCharactersResult = .error(NetworkError.someError)
        viewMock.showErrorViewExpectation = XCTestExpectation(description: "wait for showErrorView")

        // When
        sut.viewReady()

        // Then
        wait(for: [viewMock.showErrorViewExpectation!], timeout: 1.0)
    }

    func testViewReady_whenGetCharactersReturnsEmptyList_thenShowErrorView() {
        // Given
        interactorMock.getCharactersResult = .just(CharactersFactory.charactersEmptyList)
        viewMock.showErrorViewExpectation = XCTestExpectation(description: "wait for showErrorView")

        // When
        sut.viewReady()

        // Then
        wait(for: [viewMock.showErrorViewExpectation!], timeout: 1.0)
    }

    func testRetryButtonPressed_whenCalled_thenRetryGetCharacters() {
        // Given
        interactorMock.getCharactersResult = .error(NetworkError.someError)

        // When
        sut.retryButtonPressed()

        // Then
        XCTAssertTrue(interactorMock.spy.wasCallPerformed(call: InteractorCalls.getCharacters))
        XCTAssertTrue(viewMock.spy.wasCallPerformed(call: ViewCalls.showLoading))
    }

    func testMoreResultsPressed_whenCalled_thenGetCharacters() {
        // Given
        interactorMock.getCharactersResult = .error(NetworkError.someError)

        // When
        sut.moreResultsButtonPressed()

        // Then
        XCTAssertTrue(interactorMock.spy.wasCallPerformed(call: InteractorCalls.getCharacters))
        XCTAssertTrue(viewMock.spy.wasCallPerformed(call: ViewCalls.showLoading))
    }

    func testMoreResultsPressed_whenGetCaractersFails_thenShowErrorAlert() {
        // Given
        interactorMock.getCharactersResult = .just(CharactersFactory.characters)
        interactorMock.getFavCharactersResult = []
        sut.viewReady()
        interactorMock.getCharactersResult = .error(NetworkError.someError)
        viewMock.showErrorAlertExpectation = XCTestExpectation(description: "wait for showErrorAlert")

        // When
        sut.moreResultsButtonPressed()

        // Then
        wait(for: [viewMock.showErrorAlertExpectation!], timeout: 1.0)
    }

    func testDidSelect_whenCalled_thenShowCharacterDetail() {
        // Given
        let character = CharactersFactory.character

        // When
        sut.didSelect(character: character)

        // Then
        XCTAssertTrue(wireframeMock.spy.wasCallPerformed(call: WireframeCalls.presentDetail))
    }

    func testFavNavButtonPressed_whenCalled_thenToogleFavCharactersButton() {
        // Given
        interactorMock.getFavCharactersResult = []

        // When
        sut.favNavButtonPressed()

        // Then
        XCTAssertTrue(viewMock.spy.wasCallPerformed(call: ViewCalls.toogleFavCharactersButton))
    }

    func testFavNavButtonPressed_whenFavCharacterListIsNotEmpty_thenFillTableView() {
        // Given
        interactorMock.getFavCharactersResult = CharactersFactory.characterList

        // When
        sut.favNavButtonPressed()

        // Then
        XCTAssertTrue(viewMock.spy.wasCallPerformed(call: ViewCalls.fillTableView))
    }

    func testFavNavButtonPressed_whenFavCharacterListIsEmpty_thenShowNoDataView() {
        // Given
        interactorMock.getFavCharactersResult = []

        // When
        sut.favNavButtonPressed()

        // Then
        XCTAssertTrue(viewMock.spy.wasCallPerformed(call: ViewCalls.showNoDataView))
    }

    func testDidSelectFav_whenCharacterIsNotInDatabase_thenSaveCharacter() {
        // Given
        let character = CharactersFactory.character
        interactorMock.getFavCharactersResult = []

        // When
        sut.didSelectFav(character: character)

        // Then
        XCTAssertTrue(interactorMock.spy.wasCallPerformed(call: InteractorCalls.saveFav))
    }

    func testDidSelectFav_whenCharacterIsInDatabase_thenDeleteCharacter() {
        // Given
        let character = CharactersFactory.characterInDatabase
        interactorMock.getFavCharactersResult = [CharactersFactory.character]

        // When
        sut.didSelectFav(character: character)

        // Then
        XCTAssertTrue(interactorMock.spy.wasCallPerformed(call: InteractorCalls.deleteFav))
    }
}
