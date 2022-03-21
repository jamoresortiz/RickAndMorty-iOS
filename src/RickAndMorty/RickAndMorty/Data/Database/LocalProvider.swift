import Foundation

final class LocalProvider {

    static let kFavCharacters = "kFavCharacters"
    private let defaults: UserDefaults

    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
}

extension LocalProvider: LocalProviderInterface {

    func saveFav(character: Character) {
        var characterList = getFavCharacters()
        characterList.append(character)
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(characterList) {
            defaults.set(data, forKey: Self.kFavCharacters)
        }
    }

    func deleteFav(character: Character) {
        var characterList = getFavCharacters()
        if let indexOf = characterList.firstIndex(where: {$0.id == character.id}) {
            characterList.remove(at: indexOf)
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(characterList) {
                defaults.set(data, forKey: Self.kFavCharacters)
            }
        }
    }

    func getFavCharacters() -> [Character] {
        let decoder = JSONDecoder()
        guard
            let data = defaults.data(forKey: Self.kFavCharacters),
            let characterList = try? decoder.decode([Character].self, from: data)
        else {
            return [Character]()
        }
        return characterList
    }


}
