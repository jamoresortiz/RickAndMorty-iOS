import RxSwift

public protocol CharactersRepositoryInterface {
    func getCharacters(with page: Int) -> Single<Characters>
}
