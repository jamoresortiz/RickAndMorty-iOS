import RxSwift
import Moya

final class CharacterListPresenter {

    weak var view: CharacterListViewInterface?
    private let wireframe: CharacterListWireframeInterface
    private let interactor: CharacterListInteractorInterface
    private let disposeBag: DisposeBag

    init(wireframe: CharacterListWireframeInterface,
         interactor: CharacterListInteractorInterface) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.disposeBag = DisposeBag()
    }
}

extension CharacterListPresenter: CharacterListPresenterInterface {

    func viewReady() {
        getCharacters()
    }

    func retryButtonPressed() {
        getCharacters()
    }

    func didSelect(character: Character) {
        wireframe.presentDetail(character: character)
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
                    // TODO 😖
                    print("Result: \(result)")
                case let .error(error):
                    // TODO 😖
                    print("Error: \(error)")
                }
            }.disposed(by: disposeBag)
    }
}
