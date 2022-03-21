import UIKit
import RxSwift

protocol CharacterListConfiguratorInterface {
    func prepareScene() -> UIViewController?
}

protocol CharacterListViewInterface: AnyObject {
    func initialSetup(with viewData: CharacterListViewData)
    func fillTableView(with characterList: [Character], canLoadMoreData: Bool, needScrollToTop: Bool)
    func fillTableView(with characterList: [Character])
    func toogleFavCharactersButton(dependingOf isFavsShown: Bool)
    func showLoading()
    func hideLoading()
    func showErrorView()
    func showNoDataView()
    func showErrorAlert()
    func hidePlaceholder()
}

protocol CharacterListPresenterInterface {
    func viewReady()
    func retryButtonPressed()
    func didSelect(character: Character)
    func didSelectFav(character: Character)
    func moreResultsButtonPressed()
    func favNavButtonPressed()
}

protocol CharacterListWireframeInterface {
    func presentDetail(of character: Character)
    func presentFavCharacters()
}

protocol CharacterListInteractorInterface {
    func getCharacters(with page: Int) -> Single<Characters>
    func getFavCharacters() -> [Character]
    func saveFav(character: Character)
    func deleteFav(character: Character)
}


