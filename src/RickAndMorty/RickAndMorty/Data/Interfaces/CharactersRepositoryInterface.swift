import RxSwift

public protocol CharactersRepositoryInterface {
    func getCharacters(page: Int) -> Single<[Character]>
}
