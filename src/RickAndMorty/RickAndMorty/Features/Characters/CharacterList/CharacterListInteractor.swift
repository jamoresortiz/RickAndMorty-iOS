import RxSwift

final class CharacterListInteractor {

    private let charactersRepository: CharactersRepositoryInterface

    init(charactersRepository: CharactersRepositoryInterface) {
        self.charactersRepository = charactersRepository
    }
}

extension CharacterListInteractor: CharacterListInteractorInterface {

    func getCharacters(page: Int) -> Single<[Character]> {
        charactersRepository.getCharacters(page: page)
    }
}
