import RxSwift
import Moya

final class CharacterListPresenter {

    // Dependencies
    weak var view: CharacterListViewInterface?
    private let wireframe: CharacterListWireframeInterface
    private let interactor: CharacterListInteractorInterface

    // Params
    private let disposeBag: DisposeBag
    private var characterList: [Character]
    private var favCharacterList: [Character]
    private var isFavsShown: Bool
    private let initialPage = 1
    private var totalPages: Int
    private var nextPage: Int

    init(wireframe: CharacterListWireframeInterface,
         interactor: CharacterListInteractorInterface) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.disposeBag = DisposeBag()
        self.characterList = [Character]()
        self.favCharacterList = [Character]()
        self.isFavsShown = false
        self.nextPage = self.initialPage
        self.totalPages = self.nextPage
    }
}

extension CharacterListPresenter: CharacterListPresenterInterface {

    func viewReady() {
        let viewData = CharacterListViewData(
            title: "Rick & Morty",
            moreResultsButtonTitle: "Tap to show more results"
        )
        view?.initialSetup(with: viewData)
        getCharacters()
    }

    func retryButtonPressed() {
        getCharacters()
    }

    func didSelect(character: Character) {
        wireframe.presentDetail(of: character)
    }

    func didSelectFav(character: Character) {
        addOrDeleteFav(character: character)
        if isFavsShown {
            let newCharacterList = getFavCharactersSortedById()
            if newCharacterList.isEmpty {
                view?.showNoDataView()
            } else {
                view?.fillTableView(with: newCharacterList)
            }
        } else {
            let newCharacterList = getListCheckingFavCharacters(from: characterList)
            view?.fillTableView(with: newCharacterList)
        }
    }

    func moreResultsButtonPressed() {
        getCharacters()
    }

    func favNavButtonPressed() {
        view?.hidePlaceholder()
        if isFavsShown {
            characterList = getListCheckingFavCharacters(from: characterList)
            if characterList.isEmpty {
                view?.showErrorView()
            } else {
                view?.fillTableView(
                    with: getListCheckingFavCharacters(from: characterList),
                    canLoadMoreData: nextPage <= totalPages,
                    needScrollToTop: true
                )
            }
        } else {
            favCharacterList = interactor.getFavCharacters().sorted(by: { $0.id < $1.id })
            if favCharacterList.isEmpty {
                view?.showNoDataView()
            } else {
                view?.fillTableView(
                    with: favCharacterList,
                    canLoadMoreData: false,
                    needScrollToTop: true
                )
            }
        }
        isFavsShown = !isFavsShown
        view?.toogleFavCharactersButton(dependingOf: isFavsShown)
    }
}

private extension CharacterListPresenter {

    func getCharacters() {
        view?.showLoading()
        interactor.getCharacters(with: nextPage)
            .subscribe { [weak self] in
                self?.view?.hideLoading()
                switch $0 {
                case let .success(result):
                    if result.characterList.isEmpty {
                        self?.handleError()
                        return
                    }
                    self?.handleSuccess(characters: result)
                case .error:
                    self?.handleError()
                }
            }.disposed(by: disposeBag)
    }

    func handleSuccess(characters: Characters) {
        characterList += getListCheckingFavCharacters(from: characters.characterList)
        totalPages = characters.characterInfo.pages
        nextPage += 1
        view?.fillTableView(
            with: characterList,
            canLoadMoreData: nextPage <= totalPages,
            needScrollToTop: false
        )
    }

    func handleError() {
        nextPage == initialPage ? view?.showErrorView() : view?.showErrorAlert()
    }

    func getListCheckingFavCharacters(from characterList: [Character]) -> [Character] {
        var newCharacterList = getListSettingIsFavToFalse(from: characterList)
        let favCharacterList = interactor.getFavCharacters()

        newCharacterList = getListSettingIsFav(
            dependingOf: newCharacterList,
            and: favCharacterList
        )
        return newCharacterList
    }

    func getListSettingIsFavToFalse(from characterList: [Character]) -> [Character] {
        var newCharacterList = characterList
        for index in 0..<newCharacterList.count {
            newCharacterList[index] = Character(from: characterList[index], isFav: false)
        }
        return newCharacterList
    }

    func getListSettingIsFav(dependingOf characterList: [Character], and favCharacterList: [Character]) -> [Character] {
        var newCharacterList = characterList
        favCharacterList.forEach { favCharacter in
            if let indexOf = newCharacterList.firstIndex(where: {$0.id == favCharacter.id}) {
                newCharacterList[indexOf] = favCharacter
            }
        }
        return newCharacterList
    }

    func getFavCharactersSortedById() -> [Character] {
        interactor.getFavCharacters().sorted(by: { $0.id < $1.id })
    }

    func addOrDeleteFav(character: Character) {
        let newValue = Character(from: character, isFav: !character.isFav)
        character.isFav ? interactor.deleteFav(character: newValue) : interactor.saveFav(character: newValue)
    }
}
