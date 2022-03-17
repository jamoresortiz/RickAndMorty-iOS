import RxSwift

protocol CharacterListViewInterface: AnyObject {
    func set(title: String)
    func configureTableView(characterListViewData: [CharacterViewData])
    func showLoading()
    func hideLoading()
    func showNoDataView()
    func didSelect(at row: Int)
}

protocol CharacterListPresenterInterface {
    func viewReady()
    func retryButtonPressed()
    func didSelect(at row: Int)
}

protocol CharacterListWireframeInterface {
    func presentDetailOf(character: Character)
    func presentFavCharacters()
}

protocol CharacterListInteractorInterface {
    func getCharacters(page: Int) -> Single<[Character]>
}
