import RxSwift
import Moya

final class CharacterListPresenter {

    // Dependencies
    weak var view: CharacterListViewInterface?
    private let wireframe: CharacterListWireframeInterface
    private let interactor: CharacterListInteractorInterface

    // Params
    private let disposeBag: DisposeBag
    private var characterList: [Character]?

    init(wireframe: CharacterListWireframeInterface,
         interactor: CharacterListInteractorInterface) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.disposeBag = DisposeBag()
    }
}

extension CharacterListPresenter: CharacterListPresenterInterface {

    func viewReady() {
        view?.set(title: "Rick & Morty")
        getCharacters()
    }

    func retryButtonPressed() {
        getCharacters()
    }

    func didSelect(character: Character) {
        wireframe.presentDetailOf(character: character)
    }

    func didSelect(at row: Int) {
        guard
            let character = characterList?[safe: row]
        else {
            assertionFailure("Fail to select a character")
            return
        }
        wireframe.presentDetailOf(character: character)
    }
}

private extension CharacterListPresenter {

    func getCharacters() {
        view?.showLoading()
        interactor.getCharacters(page: 1)
            .subscribe { [weak self] in
                self?.view?.hideLoading()
                switch $0 {
                case let .success(result):
                    print("Result: \(result)")
                    self?.handleSuccess(characterList: result)
                case let .error(error):
                    // TODO 😖
                    print("Error: \(error)")
                }
            }.disposed(by: disposeBag)
    }

    func handleSuccess(characterList: [Character]) {
        self.characterList = characterList
        if characterList.isEmpty {
            view?.showNoDataView()
        } else {
            let characterListViewData = makeCharacterListViewData(characterList: characterList)
            view?.configureTableView(characterListViewData: characterListViewData)
        }
    }

    func makeCharacterListViewData(characterList: [Character]) -> [CharacterViewData] {
        characterList.compactMap {
            return CharacterViewData(
                imageURL: $0.image,
                name: $0.name
            )
        }
    }
}
