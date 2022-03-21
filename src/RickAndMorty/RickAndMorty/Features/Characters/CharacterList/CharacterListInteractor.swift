import RxSwift

final class CharacterListInteractor {

    private let charactersRepository: CharactersRepositoryInterface
    private let localProvider: LocalProviderInterface

    init(charactersRepository: CharactersRepositoryInterface,
         localProvider: LocalProviderInterface) {
        self.charactersRepository = charactersRepository
        self.localProvider = localProvider
    }
}

extension CharacterListInteractor: CharacterListInteractorInterface {

    func getCharacters(with page: Int) -> Single<Characters> {
        charactersRepository.getCharacters(with: page)
    }

    func getFavCharacters() -> [Character] {
        localProvider.getFavCharacters()
    }

    func saveFav(character: Character) {
        localProvider.saveFav(character: character)
    }

    func deleteFav(character: Character) {
        localProvider.deleteFav(character: character)
    }
}
