import RxSwift

protocol CharacterListViewInterface: AnyObject {
    func showLoading()
    func hideLoading()
    func showNoDataView()
    func didSelect(character: Character)
}

protocol CharacterListPresenterInterface {
    func viewReady()
    func retryButtonPressed()
    func didSelect(character: Character)
}

protocol CharacterListWireframeInterface {
    func presentDetail(character: Character)
    func presentFavCharacters()
}

protocol CharacterListInteractorInterface {
    func getCharacters(page: Int) -> Single<[Character]>
}
